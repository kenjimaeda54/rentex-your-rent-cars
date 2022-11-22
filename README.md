# Rentex 
Aluguel de carros consumindo [API](https://github.com/kenjimaeda54/rentex-api-express) criado em Node JS 


## Feature
- Abaixo exemplo como alterar entre os estilos de navegação 
- Em alguns momentos na aplicação era todo preto, outros brancos e alguns não haviam barra de navegação 
- Se reparar abaixo criei um helper para trocar as cores de navegação, nome dado ao helper e makeNavigationController

```swift

//Home View Controller
//em algums momenots minha navegacao escondia a barra,aqui garanto que sera exebida
navigationController?.setNavigationBarHidden(false, animated: true)

//para lightContentRefletir precisa o estilo ser .black
navigationController?.navigationBar.barStyle = .black

if let navigation = navigationController?.navigationBar{
			makeNavigationController(color: "black", navigation: navigation)
}

//helper makeNavigationController
func makeNavigationController(color: String,navigation: UINavigationBar) {
	let apperance = UINavigationBarAppearance()
	apperance.configureWithOpaqueBackground()
	apperance.backgroundColor = UIColor(named: color)
	apperance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
	navigation.scrollEdgeAppearance = apperance
	navigation.standardAppearance = apperance
	
	
}
		

//DetailsViewController
//remover o titulo de back

self.navigationController?.navigationBar.topItem?.title = "";
navigationController?.navigationBar.tintColor = .black

if let navigation = navigationController?.navigationBar {
			makeNavigationController(color: "white", navigation: navigation)
}

override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
  
 
// RentDateSelectedViewController
if let navigation = navigationController?.navigationBar{
			makeNavigationController(color: "black", navigation: navigation)
}
let backButton = UIBarButtonItem()
backButton.title = ""
navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
navigationController?.navigationBar.tintColor = .white



```

##

- Para lidar com calendário customizado usei a lib [FsCaelndar](https://github.com/WenchaoD/FSCalendar) e as datas [Swift Date](https://cocoapods.org/pods/SwiftDate)
- Pode usar esse [guia](https://www.youtube.com/watch?v=FipNDF7g9tE) como referência
- As datas finais eram atualizadas dinamicamente conforme  selecionada, para realizar esse efeito eu removia a view e criava novamente com a data final
- Não pode esquecer de realizar DispatachQueue a cada retorno da  requisição, porque elas são feitas fora da thread  main

```swift 

//preparando o calendario
func prepareFsCalendar(_ dates: [String]) {
		let listDate: [DateInRegion] =  dates.map {
			return $0.toDate("yyyy-MM-dd")!
		}
		
		orderDate = DateInRegion.sortedByNewest(list: listDate)
		
		fsCalendar.delegate = self
		fsCalendar.dataSource  = self
	
		
		//MARK: - FScalendar aparence
		fsCalendar.allowsMultipleSelection = true
		fsCalendar.appearance.titleFont = UIFont(name: "Inter-Regular", size: 15)
		fsCalendar.appearance.headerTitleFont =  UIFont(name: "Archivo-SemiBold", size: 20)
		fsCalendar.appearance.headerTitleColor = UIColor(named: "black")
		fsCalendar.appearance.caseOptions = [.headerUsesCapitalized,.weekdayUsesUpperCase]
		fsCalendar.appearance.weekdayFont = UIFont(name: "Archivo-SemiBold", size: 10)
		fsCalendar.appearance.weekdayTextColor = UIColor(named: "gray200")
		fsCalendar.appearance.borderRadius = 0
		fsCalendar.appearance.selectionColor = UIColor(named: "red50")
		
		fsCalendar.reloadData()
		
	}
  


//seus delegate
//MARK: -FSCalendarDelegate,FSCalendarDataSource
extension RentDateSelectedViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
	
	//MARK: - Min e Max
	func minimumDate(for calendar: FSCalendar) -> Date {
		
		return orderDate[orderDate.count - 1].date
	}
	
	func maximumDate(for calendar: FSCalendar) -> Date {
		return orderDate[0].date
	}
	
	//dentro de cada mês existem dias que não estão disponíveis,
	//na lógica abaixo  impedira de selecionar esses dias
	func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
		return dateAvailabel(date)
	}
	
	func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
		return dateAvailabel(date) ? nil : UIColor(named: "gray200")
	}
	
	
	//MARK: - DidSelect and Deselect
	
	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		let dateFormat = date.toFormat("yyyy/MM/dd")
		
		
		dateSelected.append(dateFormat)
		makeLabelSelected(dateFormat)
		
		if dateSelected.count > 0 {
			btnConfirm.isEnabled = true
		}
		
	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		let dateFormat = date.toFormat("yyyy/MM/dd")
		
		let indexRemove = dateSelected.firstIndex(where: {
			return $0 == dateFormat
		})
		
		if let index  = indexRemove {
			dateSelected.remove(at: index)
		}
		
    //removendo a view
		self.view.willRemoveSubview(labelFinalDate)
		makeLabelDeSelected(dateFormat)
		
		//desativar button
		if dateSelected.count == 0 {
			btnConfirm.isEnabled = false
		}
		
	}
	
	
}


```

## 
- As requisições foram feitas usando o [Almofire](https://github.com/Alamofire/Alamofire)

```swift
func fetchData(url: String,typeRequest: String? = "") {
		
		AF.request(url).response { response in
			
			if let error =  response.error {
				print(error)
				return
			}
			
			if typeRequest == "cars" {
				
				if let data = response.data {
					do {
						let data = try JSONDecoder().decode([CarsModel].self, from: data)
						delegateCar?.didUpdateRequestCars(data)
					}catch{
						delegateCar?.didFailWithErrorCar(error)
					}
				}
				return
			}
			
			
			
			if typeRequest == "schedulesByUser" {
				
				if let data = response.data {
					do {
						let data = try JSONDecoder().decode([SchedulesByUserModel].self, from: data)
						delegateSchedulesByUser?.didUpdateRequestSchedulesByUser(data)
					}catch{
						delegateSchedulesByUser?.didFailWithErrorSchedulesByUser(error)
					}
				}
				return
			}
			
			if let data = response.data {
				do {
					let data = try JSONDecoder().decode(SchedulesByCarsModel.self, from: data)
					delegateSchedules?.didUpdateRequestSchedules(data)
				}catch{
					delegateSchedules?.didFailWithErrorSchedules(error)
				}
			}
		}
	}
	
	func postData(parameters: [String:Any],url: String) {
		
		AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default).validate(statusCode: 200..<299).responseData {response  in
			
			switch response.result {
			case .failure(let error):
				print(error)
				delegatePost?.didFailWithErrorPost("Não pode alugar este carro, porque  está  na sua lista de  alugados")
			case .success(let data):
				print(data)
				delegatePost?.shouldReturnWithSucess(true)
			}
			
		}
	}

```

## Como iniciar o projeto
- Clone o projeto
- Navega até a pasta em sistemas unix e cd rentex-your-rent-cars-swift
- Instala as dependências pod install --repo-update
- Inicia o xcode, abra o diretório clonado e o  arquivo com a extensão xcworkspace, apos isto e só clicar na aba acima no run > 


