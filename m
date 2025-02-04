Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944A2063F3
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667750; cv=none; b=N4XPjmpe7A1u7nEf3gVzjFDai+ykesTukD8dwQUItKaJDnrdD0RN6Xv/SjuMQOgPZEaoUvhs2lgs3r5QgB8MIN3PZ8HmPa4U16VzJnfX6jDFVQx2Tq4ZijEUTT4MKsC9gHPV/KjA1bqIsV+J1+E/j09VqJLZOABd4ujiBuo0XdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667750; c=relaxed/simple;
	bh=YhFXqUhtcuJP2TxwJrxYY1ZUI1nI99wxEUasmBdBhAs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHh0goOjmBbr8fLCtlsR0tqDZF7HUkUVyMw4WupvMBamsdJostMOgObob8v+Pou8Q8/qu5P9h6FBUbE6oyFj1aFrMbL2cXYNj0wTCEhidsk9cHwbE7XeFVv0YGFlwfDJK80rt6aah+c0nRkH5L4OQ2PCKqUAFNkVvw3ZGd51sjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnLP70WTfz6HJdB;
	Tue,  4 Feb 2025 19:14:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 735F41400CA;
	Tue,  4 Feb 2025 19:15:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 12:15:42 +0100
Date: Tue, 4 Feb 2025 11:15:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sweta Kumari <s5.kumari@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/1] Added support for get/set alert configuration
 commands
Message-ID: <20250204111541.00002ef0@huawei.com>
In-Reply-To: <20250203114445.64088-2-s5.kumari@samsung.com>
References: <20250203114445.64088-1-s5.kumari@samsung.com>
	<CGME20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611@epcas5p3.samsung.com>
	<20250203114445.64088-2-s5.kumari@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  3 Feb 2025 17:14:45 +0530
Sweta Kumari <s5.kumari@samsung.com> wrote:

> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
Hi Sweta,

Thanks for the patch. Great to see someone working on these
features.   As in previous thread, in general RB tags that are
given before public posting aren't really very useful.  Reviews
can mean very different things in different companies / groups within
them.  Much prefer to see a final round of review done on the public
mailing list if possible.

Various comments inline.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 20 ++++++++
>  include/hw/cxl/cxl_device.h | 24 ++++++++++
>  3 files changed, 135 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..7a054c059d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -86,6 +86,9 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIGURATION 0x1
> +        #define SET_ALERT_CONFIGURATION 0x2
>      SANITIZE    = 0x44,
>          #define OVERWRITE     0x0
>          #define SECURE_ERASE  0x1
> @@ -1625,6 +1628,90 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 Section 8.2.9.9.3.2 Get Alert Configuration (Opcode 4201h) */

For new commands, preference is for spec references being to
the latest spec as that's the one that is downloadable via a click through
on the website.

> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in,

Align immediate after ( unless we have very long lines.

> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *out = (void *)payload_out;

blank line here.

> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
> +    *len_out = sizeof(ct3d->alert_config);

blank line here.

> +    return CXL_MBOX_SUCCESS;
> +
> +}
> +
> +/* CXL r3.1 Section 8.2.9.9.3.3 Set Alert Configuration (Opcode 4202h) */
> +static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
> +    struct {
> +        CXLValidEnableAlerts valid_alert_actions;
> +        CXLValidEnableAlerts enable_alert_actions;

uint8_t for both of these + defines.

> +        uint8_t lupwt;

Longer names here as below.

> +        uint8_t reserve;
> +        uint16_t dotpwt;
> +        uint16_t dutpwt;
> +        uint16_t cvmepwt;
> +        uint16_t cpmepwt;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +
> +    if (in->valid_alert_actions.lupwt) {
> +        if ((in->lupwt > 100) || (in->lupwt >= alert_config->lucat)) {

Add a spec reference for these constraints. Looks like they
are in the get alert configuration output table.

> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        if (in->enable_alert_actions.lupwt) {
> +            alert_config->lupwt = in->lupwt;

That's interesting.  Do we only write it when enabled. I would have
thought valid was enough.  Spec reference in a comment would help
for this first case at least. No need to replicate in the
others if it is a common thing.


> +        }
> +        alert_config->enable_alerts.lupwt = in->enable_alert_actions.lupwt;
> +    }
> +
> +    if (in->valid_alert_actions.dotpwt) {
> +        if (in->dotpwt >= alert_config->dotcat) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        if (in->enable_alert_actions.dotpwt) {
> +            alert_config->dotpwt = in->dotpwt;
> +        }
> +        alert_config->enable_alerts.dotpwt = in->enable_alert_actions.dotpwt;
> +    }
> +
> +    if (in->valid_alert_actions.dutpwt) {
> +        if (in->dutpwt < alert_config->dutcat) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        if (in->enable_alert_actions.dutpwt) {
> +            alert_config->dutpwt = in->dutpwt;
> +        }
> +        alert_config->enable_alerts.dutpwt = in->enable_alert_actions.dutpwt;
> +    }
> +
> +    if (in->valid_alert_actions.cvmepwt) {
> +        if (in->enable_alert_actions.cvmepwt) {
> +            alert_config->cvmepwt = in->cvmepwt;
> +        }
> +        alert_config->enable_alerts.cvmepwt = in->valid_alert_actions.cvmepwt;
> +    }
> +
> +    if (in->valid_alert_actions.cpmepwt) {
> +        if (in->enable_alert_actions.cpmepwt) {
> +            alert_config->cpmepwt = in->cpmepwt;
> +        }
> +        alert_config->enable_alerts.cpmepwt = in->valid_alert_actions.cpmepwt;
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* Perform the actual device zeroing */
>  static void __do_sanitization(CXLType3Dev *ct3d)
>  {
> @@ -2859,6 +2946,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
> +    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
> +        cmd_get_alert_config, 0, 0 },
> +    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
> +        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
>          (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>           CXL_MBOX_SECURITY_STATE_CHANGE |
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5f365afb4d..ce5a4962da 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -956,6 +956,25 @@ static DOEProtocol doe_comp_prot[] = {
>      { }
>  };
>  
> +/*
> + * Initialize CXL device alerts with default threshold values.
> + */
> +static void init_alert_config(CXLType3Dev *ct3d)
> +{
> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
> +
> +    memset(&alert_config->valid_alerts, 0, sizeof(CXLValidEnableAlerts));
> +    memset(&alert_config->enable_alerts, 0, sizeof(CXLValidEnableAlerts));
> +    alert_config->lucat = 75;
> +    alert_config->lupwt = 0;
> +    alert_config->dotcat = 35;
> +    alert_config->dutcat = 10;
> +    alert_config->dotpwt = 25;
> +    alert_config->dutpwt = 20;
> +    alert_config->cvmepwt = 0;
> +    alert_config->cpmepwt = 0;
Easier to read as
      ct3d_alert_config = (CXLAlertConfig) {
          .life_used_critical_thresh = 75,
...

You can skip anything where a default of 0 is an obvious default.
Perhaps the valid_alerts and enable alerts for instance.

      };
> +}
> +
>  void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -1030,6 +1049,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
>          goto err_free_special_ops;
>      }
>  
> +    init_alert_config(ct3d);
>      pcie_cap_deverr_init(pci_dev);
>      /* Leave a bit of room for expansion */
>      rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..6acae7d74d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -581,6 +581,28 @@ typedef struct CXLSetFeatureInfo {
>      size_t data_size;
>  } CXLSetFeatureInfo;
>  
> +typedef struct CXLValidEnableAlerts {
> +    uint8_t lupwt:1;

Give these longer names.
life_used_warning_threshold etc
etc as we don't want to go find the spec to figure
out what they are.


> +    uint8_t dotpwt:1;
> +    uint8_t dutpwt:1;
> +    uint8_t cvmepwt:1;
> +    uint8_t cpmepwt:1;
> +    uint8_t reserved:3;

Generally bit fields do not play well with potential endian
variations or low level code in general.  There is too much
flexibility in how they are stored.  So better to use a
uint8_t and some defines for the bits that are set.


> +} CXLValidEnableAlerts;
> +
> +typedef struct CXLAlertConfig {
> +    CXLValidEnableAlerts valid_alerts;
> +    CXLValidEnableAlerts enable_alerts;
> +    uint8_t lucat;
Longer names.  These want to be at least vaguely comprehensible
without the spec in front of us.
lif_used_critical_thresh
life_used_warning_thresh (I'm not sure why programmable matters!)
etc

> +    uint8_t lupwt;
> +    uint16_t dotcat;
> +    uint16_t dutcat;
> +    uint16_t dotpwt;
> +    uint16_t dutpwt;
> +    uint16_t cvmepwt;
> +    uint16_t cpmepwt;
> +} QEMU_PACKED CXLAlertConfig;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -605,6 +627,8 @@ struct CXLType3Dev {
>      CXLCCI vdm_fm_owned_ld_mctp_cci;
>      CXLCCI ld0_cci;
>  
> +    CXLAlertConfig alert_config;
> +
>      /* PCIe link characteristics */
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;

