Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BB2163A2
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690182; cv=none; b=oNrCri1QhIFA2VFaxJFglH9x7r6/eHvT8CMjaAq7e3iZTS9+S1WVCKQmgnrYL1/sPoivuRvHOVzjOp0BszuE2euLFTr7kF/BZ0QijUmBIHmnMtHLsevgKi6SxDqQ6cyblbGgGZjNo2zINOi/D4U5dvlHs0Lts8/hrSTb48qmsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690182; c=relaxed/simple;
	bh=HAfpU9YouDpIPr+rwRPa5WVBNdvwzi+S8LeEzEVDg4A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLhYv2xvsozuc32pWl+PrNd6cwIXdCzxkiZlUhAoMclD8WART4VgC04ifTaBJ1DcQM2dx8EX03l6HSwsWrtj/jxaV0UhDbLVyAGNqrxzqfQw4x6+ZhdvhhFcWEYY6vGwCEwbnt3lCRQbl18LqsAJi1bJvGAXN2jfAljMYkoIZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1pWweMT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1pWweMT"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso44124016d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 04 Feb 2025 09:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738690179; x=1739294979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAfNmL7y6wqJRaNH76LKIZ30Wit9wiWMhdHHjS65G34=;
        b=M1pWweMT9Omn+e0sq2I/Ixqasn9PF3O/yx3KxzzpO6h/l+kDbc1/ic0aCIfjo1l+I7
         /tWv7dAm29NEUdyQ0ZEd4V8+M0tTux/lFUU8KRTZlGycNsbpWU4AAd//O98emesU4HYR
         4Ci05v7kL8LMLWtCKjz0OX6e8wdnZhvk/HhrNgE9NOdeqycqOfUjcRkHucRy1P7llYLc
         kJiSsJj9nTKYjZ71t0GPw2uttCV1F+Ekr9NHplAeaE9QwvaXjO+sFNpPfXcR0SSpVE8I
         YWq4uvSSA8QavQHJ3sWh9o+IVF2i314YR/xHEwkLDFyJhuGs9qDEGicneSh+Jg96H5TZ
         qKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690179; x=1739294979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAfNmL7y6wqJRaNH76LKIZ30Wit9wiWMhdHHjS65G34=;
        b=os84/9utburewk8NsKDWPCCQmX3p7RycZGjrmSko+xHpDP2YTK8qcakD/RJHPOSd9Y
         cdTHCacDw2mqaw2ZcYVQbyUpYp+M0E2VtwcqJLUmcEIBwIiLW2tKu1m1lVxTy+js+yFy
         OTomytJywnRYzzSqnUc1StbEvwLzjz+hRghrZkEEtQlc8F7VJA1GrHbdDP4gy83Ku1GV
         nVTmWqDzyOTA2lOc3H29NFHS916G6o5VYrZ0ohfzFjF0WI5luEFYeQuNCYYyuQHU1OQW
         mWWOqeIUlJIPc4JKf10QUhzQNH5BuZjIgJzSIKATlViOrH8rzNeJjKGjO5jquIZu/NQe
         6cKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY4I5gBLpfA+rVuWvMJJRBw9p4WNA0Sy9J8UO+JSY2StpQRhDSK7k1g2U1cGViYjXvAh3FjNBERKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycl2TskIP7dtnrubHqS4T8daX7BYXv2ye/9JWDhdgd+0Qm3Flq
	2hwjdLQEMEw0SHF9SEsRimo/hEh3AnhH7030mcu76re3xGwKVFB3
X-Gm-Gg: ASbGncv6nF+j+qGKxA7+ZRchO/v/drLM3GYtRgnF6cr+hZ4Cy/zaVDyV04T9n3YMjXu
	TsVf/p8lQMeQRJkQYpRYNzAp38sgAzBmGU25py7zJB/GyeOY3KImy5XBOd8jZ1Jhy42IZQSeq/I
	oQdusTliLPig567Y21niv6M+kU3P2mFvj/9vqd2imjiYJ3buCg2x+jJsoLWFfySmqrCgIXV4fnv
	OexZoLZoDzJL+HZPxojIfDhYq5kuEioctQ5m6jFP/NYcWB71QPN9Ferrlmr22nrghnh1vMBl7fg
	VyDnmAo90HYnM9mYvu4=
X-Google-Smtp-Source: AGHT+IEzVSoodXM/NCXHXNDDu+T9eC6RNtpXM2WfpfVSvj6NLj+iqlBUqHhss1en6YCgO1QSj6XV4w==
X-Received: by 2002:a05:6214:2607:b0:6e4:2b39:3602 with SMTP id 6a1803df08f44-6e42b393b7amr29048936d6.15.1738690179206;
        Tue, 04 Feb 2025 09:29:39 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f0e00sm64203856d6.24.2025.02.04.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:29:38 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 4 Feb 2025 17:29:35 +0000
To: Sweta Kumari <s5.kumari@samsung.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com,
	alok.rathore@samsung.com
Subject: Re: [PATCH 1/1] Added support for get/set alert configuration
 commands
Message-ID: <Z6JOfy74ujK6r_UB@smc-140338-bm01>
References: <20250203114445.64088-1-s5.kumari@samsung.com>
 <CGME20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611@epcas5p3.samsung.com>
 <20250203114445.64088-2-s5.kumari@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203114445.64088-2-s5.kumari@samsung.com>

On Mon, Feb 03, 2025 at 05:14:45PM +0530, Sweta Kumari wrote:
> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
Hi Sweta,
Since this series only have one patch, you do not need a cover letter.
Move the commit comment in the first patch to this one and remove the
first one.

Fan
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
As mentioned by Jonathan, use r3.2.
> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLCCI *cci)
The code indent here is not right.
+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)

> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *out = (void *)payload_out;
> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
> +    *len_out = sizeof(ct3d->alert_config);
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
indent issue.

Fan
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
> +    struct {
> +        CXLValidEnableAlerts valid_alert_actions;
> +        CXLValidEnableAlerts enable_alert_actions;
> +        uint8_t lupwt;
> +        uint8_t reserve;
> +        uint16_t dotpwt;
> +        uint16_t dutpwt;
> +        uint16_t cvmepwt;
> +        uint16_t cpmepwt;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +
> +    if (in->valid_alert_actions.lupwt) {
> +        if ((in->lupwt > 100) || (in->lupwt >= alert_config->lucat)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        if (in->enable_alert_actions.lupwt) {
> +            alert_config->lupwt = in->lupwt;
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
> +    uint8_t dotpwt:1;
> +    uint8_t dutpwt:1;
> +    uint8_t cvmepwt:1;
> +    uint8_t cpmepwt:1;
> +    uint8_t reserved:3;
> +} CXLValidEnableAlerts;
> +
> +typedef struct CXLAlertConfig {
> +    CXLValidEnableAlerts valid_alerts;
> +    CXLValidEnableAlerts enable_alerts;
> +    uint8_t lucat;
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
> -- 
> 2.34.1
> 

-- 
Fan Ni (From gmail)
