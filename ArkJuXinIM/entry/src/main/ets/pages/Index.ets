import { Contact } from '../model/JuXinIMModels'
import { JuXinIMMock } from '../mock/JuXinIMMock'
import { ContactItem } from '../view/ContactItem'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local searchQuery: string = ''
  @Local contacts: Contact[] = JuXinIMMock.getContacts()
  @Local filteredContacts: Contact[] = JuXinIMMock.getContacts()

  build() {
    Column() {
      Text('巨信')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 4 })

      Row() {
        TextInput({ text: this.searchQuery, placeholder: '搜索联系人...' })
          .layoutWeight(1)
          .height(38)
          .backgroundColor('#F5F5F5')
          .borderRadius(19)
          .padding({ left: 16 })
          .onChange((value: string) => {
            this.searchQuery = value
            if (value.length > 0) {
              this.filteredContacts = this.contacts.filter(c =>
                c.name.indexOf(value) >= 0
              )
            } else {
              this.filteredContacts = this.contacts
            }
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 6 })

      List() {
        ForEach(this.filteredContacts, (contact: Contact) => {
          ListItem() {
            ContactItem({
              contact: contact,
              onItemClick: (id: string) => {
                router.pushUrl({ url: 'pages/Chat', params: { contactId: id, contactName: contact.name } })
              }
            })
          }
        })
      }
      .layoutWeight(1)
      .divider({ strokeWidth: 0.5, color: '#F0F0F0' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
