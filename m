Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71395E80AA8
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Sep 2023 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjI0NzU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Sep 2023 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjI0NzU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Sep 2023 09:55:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62CD10A
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 06:55:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RwdPg0zlHz6H7sy;
        Wed, 27 Sep 2023 21:53:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 14:55:15 +0100
Date:   Wed, 27 Sep 2023 14:55:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        "Corey Minyard" <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 12/19] hw/cxl: Implement Physical Ports status retrieval
Message-ID: <20230927145333.00003e0d@huawei.com>
In-Reply-To: <20230925161124.18940-13-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
        <20230925161124.18940-13-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

...

> +/* CXL r3.0 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
> +static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    /* CXL r3.0 Table 7-18: Get Physical Port State Request Payload */
> +    struct cxl_fmapi_get_phys_port_state_req_pl {
> +        uint8_t num_ports;
> +        uint8_t ports[];
> +    } QEMU_PACKED *in;
> +
> +    /*
> +     * CXL r3.0 Table 7-20: Get Physical Port State Port Information Block
> +     * Format
> +     */
> +    struct cxl_fmapi_port_state_info_block {
> +        uint8_t port_id;
> +        uint8_t config_state;
> +        uint8_t connected_device_cxl_version;
> +        uint8_t rsv1;
> +        uint8_t connected_device_type;
> +        uint8_t port_cxl_version_bitmask;
> +        uint8_t max_link_width;
> +        uint8_t negotiated_link_width;
> +        uint8_t supported_link_speeds_vector;
> +        uint8_t max_link_speed;
> +        uint8_t current_link_speed;
> +        uint8_t ltssm_state;
> +        uint8_t first_lane_num;
> +        uint16_t link_state;
> +        uint8_t supported_ld_count;
> +    } QEMU_PACKED;
> +
> +    /* CXL r3.0 Table 7-19: Get Physical Port State Response Payload */
> +    struct cxl_fmapi_get_phys_port_state_resp_pl {
> +        uint8_t num_ports;
> +        uint8_t rsv1[3];
> +        struct cxl_fmapi_port_state_info_block ports[];
> +    } QEMU_PACKED *out;
...

> +
> +    pl_size = sizeof(out) + sizeof(*out->ports) * in->num_ports;

In cleaning up up my tests I added a missing check on the pl size.

First term should be sizeof(*out)

> +
> +    *len_out = pl_size;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
