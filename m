Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE530CE0
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7893AA2
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 08:59:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8MFM4b1Lz6K6SZ;
	Mon, 16 Oct 2023 23:57:27 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 16:59:44 +0100
Date: Mon, 16 Oct 2023 16:59:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Gregory Price <gregory.price@memverge.com>, "Klaus
 Jensen" <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, "Klaus
 Jensen" <k.jensen@samsung.com>
Subject: Re: [PATCH 03/19] hw/cxl/mbox: Pull the CCI definition out of the
 CXLDeviceState
Message-ID: <20231016165943.000067f7@huawei.com>
In-Reply-To: <20230925161124.18940-4-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
	<20230925161124.18940-4-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 25 Sep 2023 17:11:08 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Enables having multiple CCIs per devices. Each CCI (mailbox) has it's own
> state and command list, so they can't share a single structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

I made a mess of reordering patches, so some of Davidlohr's BG ops
patch ended up in this one and the next patch. I'll put that back
where it should be in v2.

>  
> +typedef struct CXLCCI {
> +    const struct cxl_cmd (*cxl_cmd_set)[256];
> +    struct cel_log {
> +        uint16_t opcode;
> +        uint16_t effect;
> +    } cel_log[1 << 16];
> +    size_t cel_size;
> +
> +    /* background command handling (times in ms) */
> +    struct {
> +        uint16_t opcode;
> +        uint16_t complete_pct;
> +        uint16_t ret_code; /* Current value of retcode */
> +        uint64_t starttime;
> +        /* set by each bg cmd, cleared by the bg_timer when complete */
> +        uint64_t runtime;
> +        QEMUTimer *timer;
> +    } bg;
We don't have bg ops yet!

> +    size_t payload_max;
> +    /* Pointer to device hosting the CCI */
> +    DeviceState *d;
> +    /* Pointer to the device hosting the protocol conversion */
> +    DeviceState *intf;
> +} CXLCCI;
> +
