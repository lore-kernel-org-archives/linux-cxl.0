Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B95C7EE24
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjEaRsL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEaRsJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 13:48:09 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83817128
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 10:48:06 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230531174804usoutp029dd77a208b77b27157a7799215ab5f8f~kS5nl-YWb0867308673usoutp028;
        Wed, 31 May 2023 17:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230531174804usoutp029dd77a208b77b27157a7799215ab5f8f~kS5nl-YWb0867308673usoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685555284;
        bh=/yKS4my+8zIZny0bG48i6Jr5J1zTqRX5H3jtmcvBFwA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RUNB2Cp3WQ69xdk7/+y7lEIkpfUxknBxaSj1PWrnhOivE418BGX8kTtD5MXQCHpj+
         cw2M9X73NQ7ozpVsK+nkgngx/qBzYShYzDqrpPZ0UnvJW5AnwFIww2J38IWDRgxyBU
         Caf+qu74yjvwGhCxsurRHM7yVYh4iFG/LfhEu9No=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230531174804uscas1p1c3ee5bb91ce8f9b9840037875e932d56~kS5nb5uuR1562615626uscas1p1Q;
        Wed, 31 May 2023 17:48:04 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id AE.8F.42611.45887746; Wed,
        31 May 2023 13:48:04 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230531174804uscas1p2c18bceeaf3415c86d778bb42709b75bc~kS5nNbgA12466424664uscas1p22;
        Wed, 31 May 2023 17:48:04 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-64-647788548a9b
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 9C.24.64580.45887746; Wed,
        31 May 2023 13:48:04 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 31 May 2023 10:48:03 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        31 May 2023 10:48:03 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/6] cxl/mem: Introduce security state sysfs file
Thread-Topic: [PATCH 1/6] cxl/mem: Introduce security state sysfs file
Thread-Index: AQHZj4eY3Sqcm15BGU2BLNcH53LgSK91Jl2A
Date:   Wed, 31 May 2023 17:48:02 +0000
Message-ID: <20230531174754.GA2211742@bgt-140510-bm03>
In-Reply-To: <20230526033344.17167-2-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64A44FA188EE4D4FB406A1029E9324D0@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djX87ohHeUpBlveq1tMn3qB0eLEzUY2
        i9U31zBarFp4jc3i/KxTLBa3JhxjcmDzaDnyltVj8Z6XTB5TZ9d7fN4kF8ASxWWTkpqTWZZa
        pG+XwJXx59BT1oLlhhXbujvYGxhfqHcxcnJICJhIPDzzjaWLkYtDSGAlo0Tbo+1QTiuTxJxn
        s9i6GDnAqo5fqoWIr2WU6Dp9lhnC+cQoce7SczYIZxmjxI+dl5lA5rIJKErs69rOBmKLCKhL
        zFt7mxHEZhY4ySTRfsUPxBYWcJW4+mwp2AYRATeJg8cjIcqNJPr2XWAGsVkEVCV+n+9gB7F5
        Bcwk3q8/CDaeU8Bc4lb7RbAaRgExie+n1jBBjBeXuPVkPhPEa4ISi2bvYYawxST+7XrIBmEr
        Stz//pIdol5HYsHuT2wQtp1E7/nFrBC2tsSyha+ZIfYKSpyc+YQFoldS4uCKG+AQkhA4wyFx
        43sjK0TCRWJe51moImmJ6Wsus0BCLlli1UcuiHCOxPwlW6BKrCUW/lnPNIFRZRaSs2chOWkW
        kpNmITlpFpKTFjCyrmIULy0uzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMQ6f/Hc7fwXj91ke9
        Q4xMHIyHGCU4mJVEeIXCylOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrankwWEkhPLEnNTk0t
        SC2CyTJxcEo1MPWf+Z44K83TOHY6n9n+hbL80nWf3GcviXimEpBSxvjiqIqLqcB8GbMps399
        v5S1dN9v4ZAjs4sMgI5OeaQ85QMf57FV8yS+RzdnHOKTOsT+JHqDn4hihJgk+05FXb3H5854
        pG/+Lp2561HLjdBVkRXn0rR/+CmXnDM8JcLbu1dfoa9TnuOWg/xd/SonK/Y/Md63v0/YZs2e
        +brYvyLDd/mHzN/mGxrTdRwXnTP+xvPg2ia2zXM+fqsPePZ/5R3OrA8WxYWp99+900wQtDRe
        ued6kPX5DQcZ7lfE/uda77tU68A9RguT+9MP1OlVfAh3W2J7Nqt5de9lS2ljVeePNp+quGfO
        vjqnZPfF3Ys/K7EUZyQaajEXFScCAJn1ZqyyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWS2cA0UTekozzF4MA3CYvpUy8wWpy42chm
        sfrmGkaLVQuvsVmcn3WKxeLWhGNMDmweLUfesnos3vOSyWPq7HqPz5vkAliiuGxSUnMyy1KL
        9O0SuDL+HHrKWrDcsGJbdwd7A+ML9S5GDg4JAROJ45dquxg5OYQEVjNK9HQZdTFyAdmfGCV6
        L61hh3CWMUpc/r6YBaSKTUBRYl/XdjYQW0RAXWLe2tuMIDazwEkmifYrfiC2sICrxNVnS9lA
        FogIuEkcPB4JUW4k0bfvAjOIzSKgKvH7fAc7iM0rYCbxfv1BJogjkiWeLrwOVsMpYC5xq/0i
        mM0oICbx/dQaJohV4hK3nswHsyUEBCSW7DnPDGGLSrx8/I8VwlaUuP/9JTtEvY7Egt2f2CBs
        O4ne84tZIWxtiWULXzND3CAocXLmExaIXkmJgytusExglJiFZN0sJKNmIRk1C8moWUhGLWBk
        XcUoXlpcnJteUWycl1quV5yYW1yal66XnJ+7iREYwaf/HY7ZwXjv1ke9Q4xMHIyHGCU4mJVE
        eIXCylOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83rETowXEkhPLEnNTk0tSC2CyTJxcEo1MHml
        c1jpCrzzveu5hafgXcRM4V+vemP65vmynFiosVdpR9R0tYWZ5StsN1wK/BbLUMypZHg+Xu3j
        nyKt27fT0m4yFU6Zfn3ZA4+LpVt+B7V5CzyeuEglfcqv8GMCKX5rZT/WX2tY81wlJCRz2qOG
        QyeUBBK+usUEb5WOuG1km3Dw/Z05rVYdrm+fL5XboFb/jedwTHbYF02V4x+/PA5Ma3jUYGMS
        O4lj2YfWFtGX0xrPrN8aIj/tyLqS0ofbfrJevVX/pffHhK31h2KFnqTuL9oiosf/zqF4x6PH
        8a8WatTtlGWt7fz/z3Ne9HIFe46fVxTbXFbZaZodmJW47dDrDfeef40vb8yfd/OQrS87q4sS
        S3FGoqEWc1FxIgDTGYwFTwMAAA==
X-CMS-MailID: 20230531174804uscas1p2c18bceeaf3415c86d778bb42709b75bc
CMS-TYPE: 301P
X-CMS-RootMailID: 20230531174804uscas1p2c18bceeaf3415c86d778bb42709b75bc
References: <20230526033344.17167-1-dave@stgolabs.net>
        <20230526033344.17167-2-dave@stgolabs.net>
        <CGME20230531174804uscas1p2c18bceeaf3415c86d778bb42709b75bc@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 25, 2023 at 08:33:39PM -0700, Davidlohr Bueso wrote:
> Add a read-only sysfs file to display the security state
> of a device (currently only pmem):
>=20
>     /sys/bus/cxl/devices/memX/security/state
>=20
> This introduces a cxl_security_state structure that is
> to be the placeholder for common CXL security features.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++
>  drivers/cxl/core/memdev.c               | 46 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    | 11 ++++++
>  drivers/cxl/security.c                  |  3 ++
>  4 files changed, 70 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/=
testing/sysfs-bus-cxl
> index 48ac0d911801..721a44d8a482 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,16 @@ Description:
>  		affinity for this device.
> =20
> =20
> +What:		/sys/bus/cxl/devices/memX/security/state
> +Date:		June, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Reading this file will display the CXL security state for
> +		that device. Such states can be: 'disabled', or those available
> +		only for persistent memory: 'locked', 'unlocked' or 'frozen'.
> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..6e1d7d3610a2 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -107,6 +107,28 @@ static ssize_t numa_node_show(struct device *dev, st=
ruct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
> =20
> +static ssize_t security_state_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +	unsigned long state =3D cxlds->security.state;
> +
> +	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		return sysfs_emit(buf, "disabled\n");
> +	if (state & CXL_PMEM_SEC_STATE_FROZEN ||
> +	    state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT ||
> +	    state & CXL_PMEM_SEC_STATE_USER_PLIMIT)
> +		return sysfs_emit(buf, "frozen\n");
> +	if (state & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sysfs_emit(buf, "locked\n");
> +	else
> +		return sysfs_emit(buf, "unlocked\n");
> +}
> +static struct device_attribute dev_attr_security_state =3D
> +	__ATTR(state, 0444, security_state_show, NULL);
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> @@ -352,6 +374,11 @@ static struct attribute *cxl_memdev_ram_attributes[]=
 =3D {
>  	NULL,
>  };
> =20
> +static struct attribute *cxl_memdev_security_attributes[] =3D {
> +	&dev_attr_security_state.attr,
> +	NULL,
> +};
> +
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute=
 *a,
>  				  int n)
>  {
> @@ -375,10 +402,16 @@ static struct attribute_group cxl_memdev_pmem_attri=
bute_group =3D {
>  	.attrs =3D cxl_memdev_pmem_attributes,
>  };
> =20
> +static struct attribute_group cxl_memdev_security_attribute_group =3D {
> +	.name =3D "security",
> +	.attrs =3D cxl_memdev_security_attributes,
> +};
> +
>  static const struct attribute_group *cxl_memdev_attribute_groups[] =3D {
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_security_attribute_group,
>  	NULL,
>  };
> =20
> @@ -551,6 +584,15 @@ static const struct file_operations cxl_memdev_fops =
=3D {
>  	.llseek =3D noop_llseek,
>  };
> =20
> +static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +
> +	cxlds->security.state =3D 0;
> +
> +	return 0;
> +}
> +
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
> @@ -579,6 +621,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_de=
v_state *cxlds)
>  	if (rc)
>  		goto err;
> =20
> +	rc =3D cxl_memdev_security_init(cxlmd);
> +	if (rc)
> +		goto err;
> +
>  	rc =3D devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlm=
d);
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1d8e81c87c6a..5329274b0076 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -260,6 +260,15 @@ struct cxl_poison_state {
>  	struct mutex lock;  /* Protect reads of poison list */
>  };
> =20
> +/**
> + * struct cxl_security_state - Device security state
> + *
> + * @state: state of last security operation
> + */
> +struct cxl_security_state {
> +	unsigned long state;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -297,6 +306,7 @@ struct cxl_poison_state {
>   * @serial: PCIe Device Serial Number
>   * @event: event log driver state
>   * @poison: poison driver state info
> + * @security: device security state
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -336,6 +346,7 @@ struct cxl_dev_state {
> =20
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> +	struct cxl_security_state security;
> =20
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)=
;
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 4ad4bda2d18e..9da6785dfd31 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -34,6 +34,9 @@ static unsigned long cxl_pmem_get_security_flags(struct=
 nvdimm *nvdimm,
>  		return 0;
> =20
>  	sec_out =3D le32_to_cpu(out.flags);
> +	/* cache security state */
> +	cxlds->security.state =3D sec_out;
> +
>  	if (ptype =3D=3D NVDIMM_MASTER) {
>  		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
>  			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
> --=20
> 2.40.1
>=20
> =
