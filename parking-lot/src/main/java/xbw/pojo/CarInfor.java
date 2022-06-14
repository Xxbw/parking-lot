package xbw.pojo;

import lombok.Data;

@Data
public class CarInfor {
    private Integer id;
    private String carNumber;
    private Integer state;
    private Integer priceMode;
    private Integer situation;
    private Integer recordCount;
    private double allPrice;

    public CarInfor() {
    }

    public CarInfor(Integer id, String carNumber, Integer state, Integer priceMode, Integer situation, String photo) {
        this.id = id;
        this.carNumber = carNumber;
        this.state = state;
        this.priceMode = priceMode;
        this.situation = situation;
    }
}
