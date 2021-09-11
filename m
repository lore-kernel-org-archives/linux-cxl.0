Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B16C433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 01:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6782961213
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 01:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhIKBPI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhIKBPH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 21:15:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6DC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 18:13:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v123so3410262pfb.11
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NwIlbvkMYVzaZP1vShFer28JzUCLhySB1HsM0JBGYQs=;
        b=VqGSXLjHAjQrC/5iIyCPDa6RUxnKGqQgP2Ij1FieIoAehixFfugoS8ykaziUYPBc8I
         dLviakcO/gUmnlUj5oPI06M7yt9WWbb/p1gBYlpkPr66t2N+Hlxb5vCuFrEQCZBMBgRh
         KoBYviSetXzHykMIUWhnfnR6ZLMBnGwomPmjmF25+Le8fbLYKv6rfloNveqcXMqcY/05
         soR44tO/bv/oHjP/QkSJMuHBy805ARxffLx04BU6vtnCJAYxxzwE5AepwVijzT7pRdsV
         sg3FLd9pdHtBe4wDmLRmsd6279ZSmzoNKO9bcuvXbRbQ9pQ65L5a1ogkmPQKArciFb1S
         jkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NwIlbvkMYVzaZP1vShFer28JzUCLhySB1HsM0JBGYQs=;
        b=ac4aAd5mIW8RJQau2EQt2RVSnesxIaLV3t8hCfNufs1fMjnYrqIS41bgPnBhfmYYMP
         a0caQrSTmDc6BqiHHYgfEiWl8oNdC6BBx45XFGqaF7nTHKYVZklRphaSqDT4j5gbzD/p
         8HqGBGpIY1184uC6nt/cPgJQoFLyLXvd96lMaBQ5dZOUYFRb8OuYxh3HipC7BYvamA6L
         WnKatgHhyFp2AJqaebSsK5ilLguensTxvC7YBsvB7O5pLtn75A/+gJdXvViYegN0zPm8
         A+dOgr9wdkYeSH0k6W90hWsZUfqGhMJ9JSe6HG+xmygzk6UJGwJ/uT0vNp4SUm4sg6Zb
         MWjw==
X-Gm-Message-State: AOAM5316ITpQ1mOikckopDUzBFbvvR20tTYHTajuhfDnn3l0+wW/4Oe6
        Bd5LDqXR0wZ6m5LeoxGoxXEQWEJIHISwzfill1DgzQ==
X-Google-Smtp-Source: ABdhPJzlG5Ui5iC5Tg4Uzo6PmRpu1gmX1YczwY9EOaTimTBbS43kiF0Gv2s1zx0mDrFj3XQUZNkc5seROPFGlNiJyUc=
X-Received: by 2002:a05:6a00:1a10:b0:412:448c:89ca with SMTP id
 g16-20020a056a001a1000b00412448c89camr359459pfv.86.1631322835192; Fri, 10 Sep
 2021 18:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-13-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-13-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 18:13:44 -0700
Message-ID: <CAPcyv4i1nVv5XRNL0EJ1=8KVFSA7-j_RvxZxfvwwGssYtB8U2w@mail.gmail.com>
Subject: Re: [PATCH 12/13] cxl/core/bus: Enumerate all HDM decoders
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> As of the CXL 2.0 specification, every port will have between 1 and 10
> HDM decoders available in hardware. These exist in the endpoint, switch,
> and top level hostbridges. HDM decoders are required for configuration
> CXL regions, and therefore enumerating them is an important first step.
>
> As an example, the below has 4 decoders, a top level CFMWS decoder
> (0.0), a single decoder in a single host bridge (1.0), and two devices
> each with 1 decoder (2.0 and 3.0)
>
> =E2=94=9C=E2=94=80=E2=94=80 decoder0.0 -> ../../../devices/platform/ACPI0=
017:00/root0/decoder0.0
> =E2=94=9C=E2=94=80=E2=94=80 decoder1.0 -> ../../../devices/platform/ACPI0=
017:00/root0/port1/decoder1.0
> =E2=94=9C=E2=94=80=E2=94=80 decoder2.0 -> ../../../devices/platform/ACPI0=
017:00/root0/port1/devport2/decoder2.0
> =E2=94=9C=E2=94=80=E2=94=80 decoder3.0 -> ../../../devices/platform/ACPI0=
017:00/root0/port1/devport3/decoder3.0
>
> Additionally, attributes are added for a port:
>
> /sys/bus/cxl/devices/port1
> =E2=94=9C=E2=94=80=E2=94=80 active_decoders
> =E2=94=9C=E2=94=80=E2=94=80 decoder_count
> =E2=94=9C=E2=94=80=E2=94=80 decoder_enabled
> =E2=94=9C=E2=94=80=E2=94=80 max_target_count
> ...
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 161 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h      |  54 ++++++++++++--
>  2 files changed, 209 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index d056dbd794a4..b75e42965e89 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -43,6 +43,15 @@ struct attribute_group cxl_base_attribute_group =3D {
>         .attrs =3D cxl_base_attributes,
>  };
>
> +static ssize_t enabled_show(struct device *dev, struct device_attribute =
*attr,
> +                           char *buf)
> +{
> +       struct cxl_decoder *cxld =3D to_cxl_decoder(dev);
> +
> +       return sysfs_emit(buf, "%d\n", !!cxld->decoder_enabled);

In hardware there is a global disable for a set of decoders, and the
expectation that a decoder programmed to zero size is disabled. I'd
rather just have size be the indicator than a decoder_enabled flag.

> +}
> +static DEVICE_ATTR_RO(enabled);
> +
>  static ssize_t start_show(struct device *dev, struct device_attribute *a=
ttr,
>                           char *buf)
>  {
> @@ -130,6 +139,7 @@ static ssize_t target_list_show(struct device *dev,
>  static DEVICE_ATTR_RO(target_list);
>
>  static struct attribute *cxl_decoder_base_attrs[] =3D {
> +       &dev_attr_enabled.attr,
>         &dev_attr_start.attr,
>         &dev_attr_size.attr,
>         &dev_attr_locked.attr,
> @@ -249,8 +259,48 @@ static void cxl_port_release(struct device *dev)
>         kfree(port);
>  }
>
> +static ssize_t active_decoders_show(struct device *dev,
> +                                   struct device_attribute *attr, char *=
buf)
> +{
> +       struct cxl_port *port =3D to_cxl_port(dev);
> +
> +       return sysfs_emit(buf, "%*pbl\n", port->decoder_cap.count,
> +                         port->used_decoders);

What would userspace do with this ABI? A Documentation/ABI/ entry for
these would help answer that.

> +}
> +static DEVICE_ATTR_RO(active_decoders);
> +
> +static ssize_t decoder_count_show(struct device *dev,
> +                                 struct device_attribute *attr, char *bu=
f)
> +{
> +       struct cxl_port *port =3D to_cxl_port(dev);
> +
> +       return sysfs_emit(buf, "%d\n", port->decoder_cap.count);

Similar question here, can't userspace already count them by walking
the directory tree?

> +}
> +static DEVICE_ATTR_RO(decoder_count);
> +
> +static ssize_t max_target_count_show(struct device *dev,
> +                                    struct device_attribute *attr, char =
*buf)
> +{
> +       struct cxl_port *port =3D to_cxl_port(dev);
> +
> +       return sysfs_emit(buf, "%d\n", port->decoder_cap.target_count);

Just count the entries in target_list?

> +}
> +static DEVICE_ATTR_RO(max_target_count);
> +
> +static struct attribute *cxl_port_caps_attributes[] =3D {
> +       &dev_attr_active_decoders.attr,
> +       &dev_attr_decoder_count.attr,
> +       &dev_attr_max_target_count.attr,
> +       NULL,
> +};
> +
> +struct attribute_group cxl_port_attribute_group =3D {
> +       .attrs =3D cxl_port_caps_attributes,
> +};
> +
>  static const struct attribute_group *cxl_port_attribute_groups[] =3D {
>         &cxl_base_attribute_group,
> +       &cxl_port_attribute_group,
>         NULL,
>  };
>
> @@ -341,6 +391,107 @@ static int cxl_port_map_component_registers(struct =
cxl_port *port)
>         return 0;
>  }
>
> +static int port_populate_caps(struct cxl_port *port)
> +{
> +       void __iomem *hdm_decoder =3D port->regs.hdm_decoder;
> +       u32 hdm_cap;
> +
> +       hdm_cap =3D readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> +
> +       port->used_decoders =3D devm_bitmap_zalloc(&port->dev,
> +                                                cxl_hdm_decoder_count(hd=
m_cap),
> +                                                GFP_KERNEL);
> +       if (!port->used_decoders)
> +               return -ENOMEM;
> +
> +       port->decoder_cap.count =3D cxl_hdm_decoder_count(hdm_cap);
> +       port->decoder_cap.target_count =3D
> +               FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> +       port->decoder_cap.interleave11_8 =3D
> +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
> +       port->decoder_cap.interleave14_12 =3D
> +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
> +
> +       return 0;
> +}
> +
> +static int cxl_port_enumerate_hdm_decoders(struct device *host,
> +                                          struct cxl_port *port)
> +{
> +       void __iomem *hdm_decoder =3D port->regs.hdm_decoder;
> +       u32 hdm_ctrl;
> +       int i, rc =3D 0;
> +
> +       rc =3D port_populate_caps(port);
> +       if (rc)
> +               return rc;
> +
> +       if (port->decoder_cap.count =3D=3D 0) {
> +               dev_warn(host, "Found no HDM decoders\n");
> +               return -ENODEV;
> +       }
> +
> +       for (i =3D 0; i < port->decoder_cap.count; i++) {
> +               enum cxl_decoder_type type =3D CXL_DECODER_EXPANDER;
> +               struct resource res =3D DEFINE_RES_MEM(0, 0);
> +               struct cxl_decoder *cxld;
> +               int iw =3D 0, ig =3D 0;
> +               u32 ctrl;
> +
> +               cxld =3D cxl_decoder_alloc(port, is_endpoint_decoder(host=
) ? 0 :
> +                                        port->decoder_cap.target_count);
> +               if (IS_ERR(cxld)) {
> +                       dev_warn(host, "Failed to allocate the decoder\n"=
);
> +                       return PTR_ERR(cxld);
> +               }
> +
> +               ctrl =3D readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET=
(i));
> +               cxld->decoder_enabled =3D
> +                       !!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl=
);
> +               /* If the decoder is already active, parse info */
> +               if (cxld->decoder_enabled) {
> +                       set_bit(i, port->used_decoders);
> +                       iw =3D cxl_hdm_decoder_iw(ctrl);
> +                       ig =3D cxl_hdm_decoder_ig(ctrl);
> +                       if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) =
=3D=3D 0)
> +                               type =3D CXL_DECODER_ACCELERATOR;
> +                       res.start =3D readl(hdm_decoder +
> +                                         CXL_HDM_DECODER0_BASE_LOW_OFFSE=
T(i));
> +                       res.start |=3D
> +                               (u64)readl(hdm_decoder +
> +                                          CXL_HDM_DECODER0_BASE_HIGH_OFF=
SET(i))
> +                               << 32;
> +               }
> +
> +               cxld->target_type =3D type;
> +               cxld->res =3D res;
> +               cxld->interleave_ways =3D iw;
> +               cxld->interleave_granularity =3D ig;
> +
> +               rc =3D cxl_decoder_add(host, cxld, NULL);
> +               if (rc) {
> +                       dev_warn(host, "Failed to add decoder (%d)\n", rc=
);
> +                       kfree(cxld);
> +                       goto out;
> +               }
> +       }
> +
> +       /*
> +        * Enable CXL.mem decoding via MMIO for endpoint devices
> +        *
> +        * TODO: If a memory device was configured to participate in a re=
gion by
> +        * system firmware via DVSEC, this will break that region.
> +        */
> +       if (is_endpoint_decoder(host)) {
> +               hdm_ctrl =3D readl(hdm_decoder + CXL_HDM_DECODER_CTRL_OFF=
SET);
> +               writel(hdm_ctrl | CXL_HDM_DECODER_ENABLE,
> +                      hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> +       }
> +
> +out:
> +       return rc;
> +}
> +
>  static struct cxl_port *cxl_port_alloc(struct device *uport,
>                                        resource_size_t component_reg_phys=
,
>                                        struct cxl_port *parent_port)
> @@ -432,8 +583,16 @@ struct cxl_port *devm_cxl_add_port(struct device *ho=
st, struct device *uport,
>         /* Platform "switch" has no parent port or component registers */
>         if (parent_port) {
>                 rc =3D cxl_port_map_component_registers(port);
> -               if (rc)
> +               if (rc) {
> +                       dev_err(host, "Failed to map component registers\=
n");
>                         return ERR_PTR(rc);
> +               }
> +
> +               rc =3D cxl_port_enumerate_hdm_decoders(host, port);
> +               if (rc) {
> +                       dev_err(host, "Failed to enumerate HDM decoders\n=
");
> +                       return ERR_PTR(rc);
> +               }

...looks more and more like cxl_port_probe().

>         }
>
>         return port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e610fa9dd6c8..6759fe097e12 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -36,11 +36,19 @@
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
> -#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x0
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x10 + (i) * 0x20)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x14 + (i) * 0x20)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x18 + (i) * 0x20)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x1c + (i) * 0x20)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 + (i) * 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
>
>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
> @@ -49,6 +57,20 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>         return val ? val * 2 : 1;
>  }
>
> +static inline int cxl_hdm_decoder_ig(u32 ctrl)
> +{
> +       int val =3D FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> +
> +       return 8 + val;
> +}
> +
> +static inline int cxl_hdm_decoder_iw(u32 ctrl)
> +{
> +       int val =3D FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> +
> +       return 1 << val;
> +}
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -188,6 +210,12 @@ enum cxl_decoder_type {
>   */
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>
> +/*
> + * Current specification goes up to 10 double that seems a reasonable
> + * software max for the foreseeable future
> + */
> +#define CXL_DECODER_MAX_COUNT 20
> +
>  /**
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
> @@ -197,6 +225,7 @@ enum cxl_decoder_type {
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
> + * @decoder_enabled: Is this decoder currently decoding
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -208,6 +237,7 @@ struct cxl_decoder {
>         int interleave_granularity;
>         enum cxl_decoder_type target_type;
>         unsigned long flags;
> +       bool decoder_enabled;
>         int nr_targets;
>         struct cxl_dport *target[];
>  };
> @@ -255,6 +285,12 @@ struct cxl_walk_context {
>   * @decoder_ida: allocator for decoder ids
>   * @component_reg_phys: component register capability base address (opti=
onal)
>   * @regs: Mapped version of @component_reg_phys
> + * @used_decoders: Bitmap of currently active decoders for the port
> + * @decoder_cap: Capabilities of all decoders contained by the port
> + * @decoder_cap.count: Count of HDM decoders for the port
> + * @decoder_cap.target_count: Max number of interleaved downstream ports
> + * @decoder_cap.interleave11_8: Are address bits 11-8 available for inte=
rleave
> + * @decoder_cap.interleave14_12: Are address bits 14-12 available for in=
terleave
>   */
>  struct cxl_port {
>         struct device dev;
> @@ -264,6 +300,14 @@ struct cxl_port {
>         struct ida decoder_ida;
>         resource_size_t component_reg_phys;
>         struct cxl_component_regs regs;
> +
> +       unsigned long *used_decoders;
> +       struct {
> +               int count;
> +               int target_count;
> +               bool interleave11_8;
> +               bool interleave14_12;
> +       } decoder_cap;

This looks like something that would come from dev_get_drvdata(&port->dev).
