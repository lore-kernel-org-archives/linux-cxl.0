Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57142F4EA
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847707; cv=none; b=aGkyWSxORZwJxpmU1n30yIIpJ5ZClqqx8AhMStshV4++TCM3e95duw1cNtfTqKlMjIEJV09pK+K7j8EybCr14Qc289ody4lw/mDzpCxgjMdKlthGW3GDu/MDxCYHgfbWw3h5SAFIhxZmJ9CMXg584F1EtXlPeflOTsfmrFDL1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847707; c=relaxed/simple;
	bh=EbwbJJOeSpzoqsak64unU+Jk5WXtqSwJBMBM184v3E8=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=hqiyVuPoYM/SVG7X9r0hFvzoHYuQUoA+GHxSAeDa1fkjzaOB8nmeMWZGF/oI/al3J7BPYASI/maXuuc0+lFze9RxLDpevrov30UO4U/gEXbm3Nr3OPudOoJ3dGB1UcGFcBBu2T/ql2+Jcl3E8gHSUeR2KjjhtDqILdnp2X/Pkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gBejD5pC; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gBejD5pC"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240202042142epoutp01af93056e39af33f57b924e6bafbe492b~v8PEiery92485124851epoutp017
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 04:21:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240202042142epoutp01af93056e39af33f57b924e6bafbe492b~v8PEiery92485124851epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706847702;
	bh=/bFx0IMTgJKEf4fsfTzkF1nAigAyyi0Rj25HnfRCSgg=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=gBejD5pCG3UEtgkdlxFXEZgvuxJtJRu8Eah021KZNq64One+ODwm/Tt7Swmu8uXw5
	 6aetCpS8kwoOFK7wVV5A/GuHqStpMkikPQzQxFI9VGaToxowafWSw6S+sMKMD5U/2q
	 GmAE5YleQh2f7QFAQ3AOW6t+wMF4kY2WibqYFH8M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240202042141epcas2p3687132a08eff50fc3f38a0f084849ed6~v8PEBpaMk1930519305epcas2p3N;
	Fri,  2 Feb 2024 04:21:41 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TR2fF178pz4x9Q8; Fri,  2 Feb
	2024 04:21:41 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-bf-65bc6dd5581f
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.2A.10022.5DD6CB56; Fri,  2 Feb 2024 13:21:41 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state'
 *_perf_list to single 'struct cxl_dpa_perf'
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240201214731.1297389-1-dave.jiang@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
Date: Fri, 02 Feb 2024 13:21:40 +0900
X-CMS-MailID: 20240202042140epcms2p3c6f0708e85374e958df2f58416dde705
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmqe7V3D2pBq0nWS3uPr7AZjF96gVG
	ixM3G9ksVt9cw2jx4c0/Fov9T5+zWKxaeI3N4ugeDovzs06xWNyacIzJgcuj5chbVo/Fe14y
	efRtWcXoMXV2vcfnTXIBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
	uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
	89L18lJLrAwNDIxMgQoTsjN2L9rHWLBEteLMqqXMDYy9cl2MnBwSAiYSn+aeYuxi5OIQEtjB
	KDFhyU/WLkYODl4BQYm/O4RBaoQF8iUuLHzLBmILCchJ3L19igkirinxZtoqFhCbTUBd4kfn
	SbC4iECCxPbb79hAZjILTGSWmDfvDTPEMl6JGe1PWSBsaYnty7cygticAjYST3uvQcU1JH4s
	64WqF5W4ufotO4z9/th8RghbRKL13lmoGkGJBz93Q8WlJL6e+MsOslhCoJlRYvWxflYIp4FR
	omPmYagN+hKN19+DvcMr4Ctx48YPsLNZBFQltu6cxQZR4yKxfcojVhCbWUBeYvvbOcygUGEG
	enn9Ln0QU0JAWeLILRaICj6JjsN/2WF+3DHvCROErSQxpe0I1G0SEg2NW6Gme0icaLvCPoFR
	cRYiqGch2TULYdcCRuZVjGKpBcW56anFRgXG8NhNzs/dxAhOn1ruOxhnvP2gd4iRiYPxEKME
	B7OSCO9KuZ2pQrwpiZVVqUX58UWlOanFhxhNgb6cyCwlmpwPTOB5JfGGJpYGJmZmhuZGpgbm
	SuK891rnpggJpCeWpGanphakFsH0MXFwSjUwRcd7Z//2KX32uWPV/X6noEdvis8H9B+Jntbd
	9lN49iSP2WfjFlsb3GfZeWj2hxi/VUvupnEsavBh6l5/8XSD4TXvxNld02TT9Oa31l6cqflw
	QUp+ZzjbhsjDMjen2dYeulv9dHn7i7VXK/iKFG1eyx5zfmR6RW7CoeyfjnHLdp33vrMh6MHK
	JIaV7x6uj2Tc8K7abNomswnPohe/yft6+peNiwHDkpMq7xZLmF7Y+DJ3Z/fJ9t660iY1w8pl
	KtM3eETHTF61fd7/HcU3XRfYu/GsX7lvO8P9Bee4LtjsWf/U+Ka5+akAU/ULvzmX9lolSGz4
	3x/R/+DR1Alqr96u+HMq89JVmYk50i1e7VHPn05WYinOSDTUYi4qTgQAUcKKtigEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201214822epcas2p3062089e1281f483fb26eea3c80a71475
References: <20240201214731.1297389-1-dave.jiang@intel.com>
	<CGME20240201214822epcas2p3062089e1281f483fb26eea3c80a71475@epcms2p3>

On Thu, Feb 01, 2024 at 02:47:29PM -0700, Dave Jiang wrote:
> In order to address the issue with being able to expose qos_class sysfs
> attributes under 'ram' and 'pmem' sub-directories, the attributes must
> be defined as static attributes rather than under driver->dev_groups.
> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
> preparation to move the attributes to statically defined.
>
> While theoretically a partition may have multiple qos_class via CDAT, this
> has not been encountered with testing on available hardware. The code is
> simplified for now to not support the complex case until a use case is
> needed to support that.
>
> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Add to commit log about simplification (Dan)
> - Remove check for dev->driver (Dan)
> - Remove check for invalid qos_class (Dan)
> ---
>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
>  drivers/cxl/core/mbox.c |  4 +-
>  drivers/cxl/cxlmem.h    | 10 ++---
>  drivers/cxl/mem.c       | 28 ++------------
>  4 files changed, 33 insertions(+), 90 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6fe11546889f..55b82dfd794b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -210,19 +210,12 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>   return 0;
>  }
>
> -static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
> -            struct list_head *list)
> +static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> +               struct cxl_dpa_perf *dpa_perf)
>  {
> - struct cxl_dpa_perf *dpa_perf;
> -
> - dpa_perf = kzalloc(sizeof(*dpa_perf), GFP_KERNEL);
> - if (!dpa_perf)
> -     return;
> -
>   dpa_perf->dpa_range = dent->dpa_range;
>   dpa_perf->coord = dent->coord;
>   dpa_perf->qos_class = dent->qos_class;
> - list_add_tail(&dpa_perf->list, list);
>   dev_dbg(dev,
>       "DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
>       dent->dpa_range.start, dpa_perf->qos_class,
> @@ -230,20 +223,6 @@ static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
>       dent->coord.read_latency, dent->coord.write_latency);
>  }
>
> -static void free_perf_ents(void *data)
> -{
> - struct cxl_memdev_state *mds = data;
> - struct cxl_dpa_perf *dpa_perf, *n;
> - LIST_HEAD(discard);
> -
> - list_splice_tail_init(&mds->ram_perf_list, &discard);
> - list_splice_tail_init(&mds->pmem_perf_list, &discard);
> - list_for_each_entry_safe(dpa_perf, n, &discard, list) {
> -     list_del(&dpa_perf->list);
> -     kfree(dpa_perf);
> - }
> -}
> -
>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>                    struct xarray *dsmas_xa)
>  {
> @@ -263,16 +242,14 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>   xa_for_each(dsmas_xa, index, dent) {
>       if (resource_size(&cxlds->ram_res) &&
>           range_contains(&ram_range, &dent->dpa_range))
> -         add_perf_entry(dev, dent, &mds->ram_perf_list);
> +         update_perf_entry(dev, dent, &mds->ram_perf);
>       else if (resource_size(&cxlds->pmem_res) &&
>            range_contains(&pmem_range, &dent->dpa_range))
> -         add_perf_entry(dev, dent, &mds->pmem_perf_list);
> +         update_perf_entry(dev, dent, &mds->pmem_perf);
>       else
>           dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
>               dent->dpa_range.start);
>   }
> -
> - devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
>  }
>
>  static int match_cxlrd_qos_class(struct device *dev, void *data)
> @@ -293,24 +270,25 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>   return 0;
>  }
>
> +static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
> +{
> + memset(&dpa_perf, 0, sizeof(*dpa_perf));

Hello,

I think you meant dpa_perf instead of &dpa_perf, right?

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c93bf9d5253..7091619f12a9 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -272,7 +272,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)

 static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
 {
-       memset(&dpa_perf, 0, sizeof(*dpa_perf));
+       memset(dpa_perf, 0, sizeof(*dpa_perf));
        dpa_perf->qos_class = CXL_QOS_CLASS_INVALID;
 }

Thanks,
Wonjae
