Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9753BB12E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625521; cv=fail; b=MEouL25P3O7dFv+pWJjRd1rNlRkNtBKHCDXMgRyHVF9ObIWqWhS+XPW2ahI94Ry8M4KSzxz7JLsnnUR3hd5S84T2G7RDXdNQO8KEWoUU0st3+V+eKYg/T05GrMPTZFbpjUmRXdEO28PusdNY70GwvegHxIG7BrMhrAD2kCt2A+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625521; c=relaxed/simple;
	bh=7ThIHZoWc2tb9YBVbxCW42ah6r6VRYwjXeh84RiD0XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WThos73sEfWm20tZtBIugKQ4L70JAwT8vcgwCuw92C47EBofui4Y3C6Lsn/MckYQYOG/p6T89pIDo3MV9p2ZvaC7n8Yz5xRhnNgtQmqYPsBhA6AOk65HXh8b0E7DMQ2gbPRUBbT38XgGGjaKr1xwh5rpN7C0/1hOn/TrzZtPpbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baF28kgw reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baF28kgw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDkLyHenNqCVMI1HpW7hwWbtnKsKw3hBpkpbq++PlbTRSQjbV0Zsiom02AbuOWcYQayB9e2Im1MRhODvzAigBrn2KYC7pR84aqxBeA+Qifx0V8Xnw3NsjBwQcdQyCF5viE76xiA5xyKJ9BxB0wub/YUZzbe/Px2C+21CK3hSeErLUmPXeLYnYb9hWjyka3aIYjZAit1TkIB/qr00v0Vp1lCGB+DamNXAyniXEnSBoQ8mB3im+Ry2sZxKsFwsEyLdDt8I5MjWg37uV4Efa4T4C/rlXNKaY+Xh720iU9o04G0H6UoWOWlKyWOte/jcvXPq3VR4kCbCpc9A/n9ete1YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L08Y9j8qm6zFpHmXvgTvdHDBwasTQifBltELVG+lVFA=;
 b=hFJfkMzwKB0vDYvNhXhSYFcwgF5X39Y/rUs6R/TnwBBzSRF8LiYpmL2QD9ccY0RXFu8yU7wCi2sIEe0feNaBu69FQ+zqVNNfQvNIwMPawmv6SmIbzcrLrAIOZVfqm+3Ex3yuDXc5QI/56DJh7kBGIOqTw0xbFf94HD2VZzZ32LJYEWQjYFb4iPviTafaBM5wQPXcN6jDB5fA8Vh/Ezbm3vGgUHpVIum+pfb4y1ZKze3g2MnaSy6SKiQalih1u7GwzeV49/PTT5AnuylY41I6r/Un2LGQdj0C2y3KBlOM6QL2xnoNkSwEGHgOIRSfHrJDUj/ZR7Ai4BuWdmYje2baew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L08Y9j8qm6zFpHmXvgTvdHDBwasTQifBltELVG+lVFA=;
 b=baF28kgwNUrW24FjaNC/D0HxqZMMExH2SfAmWHIh1c65YPSMwBiPXlefSSOi6EB0zMoeT+Yfi4Jog6w+KOi7fwO7zWm9Jb68TxpM6meOhNhBWlddHXhEG5QHcctyYHz+BIWnivMumRP84Z3s+WcBuPG3Tue7iQ+Jwj0cDltCApBTK786TjpqNh0la5frY5kceBHHXl2lDgE09o/30/b8UidKvxbt2LAm6BeYqFIe8O4pQFQq8ZPPSchAfcu/fMmKL8Le6ZLeOYWKFXBQNb4Dmql6L38DGLdJNVYVXak3mPLkZPf5UAXobzwihFC9ZogLcff3zueOH+AYI7R4azonUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 02:11:46 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:11:45 +0000
Date: Fri, 5 Jun 2026 10:11:38 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <aiIu9vtpOldAX3nu@MWDK4CY14F>
References: <20260605003329.2584012-3-dave@stgolabs.net>
 <20260605012940.1A1EC1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605012940.1A1EC1F00898@smtp.kernel.org>
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5319ca-9ea0-4fc8-4c3e-08dec2a7cb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|4143699003|5023799004|6133799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DRZHYBF5xhNWR06PD/ZjHCEm73scUwtqfPyD3Gisk+fT6QIBaqzFHav+m793OsUaPu7kF4ZkW32OplsXb30OVv7YTbHByOa7LW4S7iZzXXAVO2lBrGSQKg9Ef6ciI32M8sCcn/4L+3ZzdCQf2pGPV2Tcxh6DkxsPRNqX1lwiipk77fUV0+WxkW1QTCXQOPeQXYYp6eYYvz+K2M+t/gNZtjMMdLD4ZdBUTu9SRHCRw7OImTVn30vYpKw+22Im7kKI5fod5xakZTgzq6zE3vTChF/NJtav0eCe3z46Eq2EI892WiyRT0ILDOEpOAW1rLSBMwAQgAP1X0uaoTCZkRVsBZ5UOeTEjSIpRxMnEstWZBlt/AYTnXbAd/QePKkRKBzUX9MctJuoMxu+M2orIxtp9pH59yy63Jnc9R7XRzy7+rflBFfHAhUQCS/SAd5avQf2+TTOosMX3FKUwQDmp5a+w1R50vKjHtFzRKyh3oLYt5Tmqv5lbRTnG4l0Nyh3siDAZne1iaj8en1jcao50nmdEWRipKTgWh3eDKr4MpNWTNc6AeGDUQBF1k7x/OWJjyIuUPT4tr42DpzLpnEy4EGCZrYy7fd264ilFvVDH+WnQdeeWaDj0chi/hiGo+chkG79uCMyFIivuNRTb9aWNYnRpKmmPyzO86ZdkxaiFhT2SrmgH/6km5oiGawihMgGw40g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(5023799004)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Ratkr79R+krKpi0oEuDle+y0/H55TyUNse7yqVEJjJt/OK97SudvlY2gSQ?=
 =?iso-8859-1?Q?IAAtgqEg1Ku9GPG2Vsm9cW43SEPLAAmASxwgvKhWScNDaZorojwbAKLxsn?=
 =?iso-8859-1?Q?Hkte9mo+P1LPoaN+eXaT5DnmXHJNI+jN7ulbF51h9h1Poih34ZyDoC5K1p?=
 =?iso-8859-1?Q?4Fnd9DCHFbv/HHXMNcJHAugXh+LJBaHWV/ufbFKo3e9oAZItVJpOa9B3wu?=
 =?iso-8859-1?Q?cuOrQFeQsjQ77iEiYQLBlCuN+aCC8En7XfnfPFq1LiY5ySK4oxo6/TonDl?=
 =?iso-8859-1?Q?AebgjuVyLAThceVcBt9JXoCbRYK0soHug3rLjOflSvHDs2jMF9ILYSJ8fc?=
 =?iso-8859-1?Q?7+lz9cM5EGouMN/DlO+7TUOfLSLKr7zvO5rh5F2lprvnHcsYkzdizYKkPD?=
 =?iso-8859-1?Q?yQYG9RbLrM/K/8UOxE8FOZwL0I1zN8YOhIllNP1aQ7SCIei7Syj8Qe2ee+?=
 =?iso-8859-1?Q?VbfmKz4gYFNjEBE+ewoEZ4FESt2jFSUKcBSCgxugWHiuHDpVgEvSUbu9yP?=
 =?iso-8859-1?Q?yZQeVPXKk7BWNK6q8aGlW44GDGRFZI43tR6hV9eOYeuEgnTrX55d+UMCwY?=
 =?iso-8859-1?Q?TaJted7eau6RvObJ4Kcgg/a9GZ8HLYNFXk1L9qWHde3uqyHzAhUPYpo4kt?=
 =?iso-8859-1?Q?vaItAR7cNJhz1mzNDDtTHk1GHC/hWni771usH+DhIENmPYuq5ky4j3bUjf?=
 =?iso-8859-1?Q?Ac0JSRFmwn2mxr9mTHuPnvyOxuDkp4iO94NsadNk8hN9rErFF6MKiDsj+6?=
 =?iso-8859-1?Q?7FAO4Jxk6j50zExG/7pdiasvmYjRVc/FsJciZmhT2uZXD7Lmh7iSs2T1cE?=
 =?iso-8859-1?Q?vLF3wY5PhMoQbPyES4wHJfi3zbKs9HzlObjCTBoix/ihIUgvDlWP6VHagx?=
 =?iso-8859-1?Q?pAyhUr+zPXbNz9LUNmeCPjTvC5V+VE7Z8ZKYh+BirTru1VQbT4wM9WqfKf?=
 =?iso-8859-1?Q?O6qQ0FrjioLBJZHceiz24utoaCvl7+bvveKSciFvnZZjfPPGTBAXY95Dtu?=
 =?iso-8859-1?Q?e8RzxZPfCjdn2fQm2sp1XcZjx8nmm4FFGWrjzUCAhwohjP5WYYwyCe+lHj?=
 =?iso-8859-1?Q?j2AP//dEPh0dzxRtznzVKjXrxQw5+xKgs8jgEAHtIpyWe3+YxV2I+MqaQU?=
 =?iso-8859-1?Q?TFyqYhpojmLWRwV/Xq1qMMVJrTUjheA9q3q0G6CnQ8U9srUUct+rmTEIG0?=
 =?iso-8859-1?Q?HTTOSSUlQdLalIL0UgJb6G4IEJ8YMWwvUvIaH8JLhvbyravy+s/a1PwOCE?=
 =?iso-8859-1?Q?g8GhZiCCTlCKdiLfsx2Lv1V/7dCsRUgVhraNKZKaErnvVUPu2eqOUJz4Pd?=
 =?iso-8859-1?Q?p+fF/oxVFNJtGron6COJkXGYxVsgcjNRT5WwHpMs1cdfCpJwRhv/5zi7hY?=
 =?iso-8859-1?Q?gKZANS3npgyOWf3oUATEfpPRLpfsKu6w1ngnvwIxq4cbsj+SpdOxAGFC4q?=
 =?iso-8859-1?Q?JocFYdp8kh8NTsBF4ZByYNvdMDJiAxcIg8IeaVkfRL+sd3lmojMygR7dT0?=
 =?iso-8859-1?Q?W2gTsrmmo8yS3aGc1/ypCzNTL+Vv8lBto1fK65uNjtCI6KEFFKFpt8fwsJ?=
 =?iso-8859-1?Q?xO0+EEVX02tviNvd64c4lELDjaBtdK12d3mGjeY1lSw4ZbpOyDZMaQ5ikj?=
 =?iso-8859-1?Q?7qgMGEj0nPGKy6GVvFZrRdbHgu7H59HOgHWwCD9sFrxNjwucLHLVSux2h2?=
 =?iso-8859-1?Q?o93KJT8xamJfX1WR+4gUGF+YySMfknkwG3QLHFw8MwqQQhSAwCJiVu0Ok+?=
 =?iso-8859-1?Q?HfFubQDCiOPRITO/rAHV0Hp3Ffq9ckkv1vsbmdkL03X1dHoxQBUe87Z6y+?=
 =?iso-8859-1?Q?PbnUxRajNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5319ca-9ea0-4fc8-4c3e-08dec2a7cb13
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:11:45.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: be9HaM8Ml9ySA7MM3N3os61sFPhN0RZdIQaSR14d3146fxk/KW5miZwvkjBiCd1qonjZCydeHt+tE/ni+DE10g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144

On Fri, Jun 05, 2026 at 01:29:39AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] Missing BI reference counting for shared Downstream Ports breaks BI coherence in cascaded switch topologies.
> - [High] A hardware-reported timeout base of 0 causes an infinite polling loop in `readx_poll_timeout`, leading to a kernel hang.
> - [High] Missing explicit commit sequence for the BI Decoder on the endpoint device.
> - [High] Topology walks in `cxl_bi_setup` and `cxl_bi_dealloc` stop early, failing to configure or rollback BI on the Root Port.
> - [High] `cxl_bi_dealloc` returns early and fails to disable BI on the endpoint hardware if the upstream port topology is unbound prior to memdev teardown.
> - [Medium] Mixing `goto`-based error handling with `__free()` scope cleanup attributes in the same function violates subsystem guidelines.
> --
> 
> commit 6dd8e8661d8e77fc7f88e425d2633e5ccda84b51
> Author: Davidlohr Bueso <dave@stgolabs.net>
> 
> cxl/pci: Add BI topology enable/disable
> 
> Implement cxl_bi_setup() which walks the CXL port topology to enable
> BI flows on the device and every component in the path between the
> device and the root port. The teardown counterpart, cxl_bi_dealloc(),
> runs automatically on cxl_mem unbind.
> 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> 
> [ ... ]
> 
> > +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> > +					     unsigned int scale,
> > +					     unsigned int base)
> > +{
> > +	static const unsigned long scale_tbl[] = {
> > +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> > +	};
> > +
> > +	if (scale >= ARRAY_SIZE(scale_tbl)) {
> > +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
> > +		return CXL_BI_COMMIT_MAXTMO_US;
> > +	}
> > +
> > +	return scale_tbl[scale] * base;
> > +}
> 
> [Severity: High]
> If the hardware provides a base of 0, could this return a 0 timeout?
> 
> [ ... ]
> 
> > +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
> > +				u32 committed_bit, u32 err_bit,
> > +				unsigned int scale, unsigned int base)
> > +{
> > +	unsigned long tmo_us, poll_us;
> > +	ktime_t start;
> > +	u32 status;
> > +	int rc;
> > +
> > +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
> > +		       __cxl_bi_get_timeout_us(dev, scale, base));
> > +	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
> > +	start = ktime_get();
> > +
> > +	rc = readx_poll_timeout(readl, status_reg, status,
> > +				status & (committed_bit | err_bit),
> > +				poll_us, tmo_us);
> 
> [Severity: High]
> Does a tmo_us of 0 passed to readx_poll_timeout cause it to poll
> indefinitely?
> 
> If a faulty or malicious device sets base to 0 and never sets the commit
> or error bits, this looks like it might result in a kernel thread spinning
> forever.
> 
> [ ... ]
> 
> > +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> > +	void __iomem *bi = dport->regs.bi_decoder;
> > +	struct cxl_port *port = dport->port;
> > +	u32 ctrl, value;
> > +	int rc;
> > +
> > +	guard(device)(&port->dev);
> > +	if (!bi)
> > +		return -EINVAL;
> > +
> > +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> > +
> > +	switch (pci_pcie_type(pdev)) {
> > +	case PCI_EXP_TYPE_ROOT_PORT:
> > +		if (enable) {
> > +			/*
> > +			 * There is no point of failure from here on,
> > +			 * BI will be enabled on the endpoint device.
> > +			 */
> > +			dport->nr_bi++;
> 
> [ ... ]
> 
> > +	case PCI_EXP_TYPE_DOWNSTREAM:
> > +		if (enable) {
> > +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> > +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
> > +		} else {
> > +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> > +				return 0;
> > +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> > +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> > +		}
> 
> [Severity: High]
> Should this case maintain a reference count for the downstream port similar
> to how dport->nr_bi is used in the PCI_EXP_TYPE_ROOT_PORT case?
> 
> In cascaded switch topologies, an upstream switch's downstream port can be
> shared by multiple downstream endpoints. If one endpoint is unbound,
> cxl_bi_dealloc will clear the BI_ENABLE bit on the shared downstream port
> unconditionally.
> 
> Could this silently break Back-Invalidate for all other active endpoints
> relying on that same path?
>

Acked on sashiko-bot's finding, 2 BI-capable endpoints behind
the same DSP can break it, first unbind breaks the second.
Switch DSP unconditionally clear BI_ENABLE on the first memdev unbind.
 
> [ ... ]
> 
> > +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> > +{
> > +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> > +	void __iomem *bi = endpoint->regs.bi_decoder;
> > +	u32 ctrl, val;
> > +
> > +	if (!bi)
> > +		return -EINVAL;
> > +
> > +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> > +
> > +	if (enable) {
> > +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> > +			if (cxlds->bi)
> > +				return 0;
> > +			dev_err(cxlds->dev,
> > +				"BI already enabled in hardware\n");
> > +			return -EBUSY;
> > +		}
> > +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> > +	} else {
> > +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> > +			if (!cxlds->bi)
> > +				return 0;
> > +			dev_err(cxlds->dev,
> > +				"BI already disabled in hardware\n");
> > +			return -EBUSY;
> > +		}
> > +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> > +	}
> > +
> > +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> > +	cxlds->bi = enable;
> > +
> > +	dev_dbg(cxlds->dev, "BI requests %s\n",
> > +		str_enabled_disabled(enable));
> > +
> > +	return 0;
> > +}
> 
> [Severity: High]
> Is an explicit commit sequence required here after writing the control
> register?
> 
> Unlike __cxl_bi_ctrl_dport which calls __cxl_bi_commit_decoder after
> modifying the control register, the endpoint function does not commit
> the changes.
> 
> If the endpoint's BI decoder requires an explicit commit, it seems the enable
> or disable operation might not take effect on the hardware.
> 
> [ ... ]
> 
> > +static void cxl_bi_dealloc(void *data)
> > +{
> > +	struct cxl_dev_state *cxlds = data;
> > +	struct cxl_dport *dport_iter, *dport;
> > +	struct cxl_port *port_iter;
> > +
> > +	if (!dev_is_pci(cxlds->dev))
> > +		return;
> > +
> > +	struct cxl_port *port __free(put_cxl_port) =
> > +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
> > +	if (!port || !cxlds->bi)
> > +		return;
> > +
> > +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> > +		cxl_bi_ctrl_endpoint_disable(cxlds);
> 
> [Severity: High]
> Does this early return prevent proper endpoint cleanup if the port topology
> is torn down before the memdev teardown?
> 
> If cxl_pci_find_port returns NULL because the upstream port was removed
> or unbound, cxl_bi_ctrl_endpoint_disable is skipped. This leaves the
> endpoint hardware with BI_ENABLE set and cxlds->bi equal to true.
> 
> If the device is subsequently rebound, cxl_bi_ctrl_endpoint_enable will see
> the hardware bit already set, print 'BI already enabled in hardware',
> and fail the probe with -EBUSY.
> 
> > +
> > +	port_iter = port;
> > +	dport_iter = dport;
> > +	while (!is_cxl_root(port_iter)) {
> > +		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
> > +
> > +		/* best effort */
> > +		if (rc)
> > +			dev_dbg(&port_iter->dev,
> > +				"BI dport disable failed: %d\n", rc);
> > +
> > +		dport_iter = port_iter->parent_dport;
> > +		port_iter = dport_iter->port;
> > +	}
> > +}
> 
> [Severity: High]
> Does this loop terminate before disabling BI on the Root Port?
> 
> In the CXL topology, the Root Port is a downstream port (dport) owned by
> the CXL Root or Host Bridge (port). When the traversal reaches the Host
> Bridge, is_cxl_root(port_iter) evaluates to true and the loop terminates
> before executing the loop body for the Root Port's dport.
> 
> [ ... ]
> 
> > +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> > +	struct cxl_dport *dport_iter, *dport, *failed;
> > +	struct cxl_port *port_iter;
> > +	struct pci_dev *pdev;
> > +	int rc;
> > +
> > +	if (!dev_is_pci(cxlds->dev))
> > +		return 0;
> > +
> > +	pdev = to_pci_dev(cxlds->dev);
> > +	struct cxl_port *port __free(put_cxl_port) =
> > +		cxl_pci_find_port(pdev, &dport);
> > +
> > +	if (!port)
> > +		return -EINVAL;
> 
> [ ... ]
> 
> > +	port_iter = port;
> > +	dport_iter = dport;
> > +	while (!is_cxl_root(port_iter)) {
> > +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
> > +		if (rc)
> > +			goto err_rollback;
> 
> [Severity: Medium]
> Is it safe to mix goto-based error handling with __free scope cleanup
> attributes in the same function?
> 
> The Cleanup and Guard Subsystem Details explicitly forbid mixing goto-based
> cleanup labels and scope-based __free declarations within the same function
> due to the potential for confusing ownership semantics and double-free bugs.
> 
> [ ... ]
> 
> > +err_rollback:
> > +	/*
> > +	 * Undo all dports enabled so far, including the failed one.
> > +	 */
> > +	failed = dport_iter;
> > +	dport_iter = dport;
> > +	port_iter = port;
> > +	while (!is_cxl_root(port_iter)) {
> > +		cxl_bi_ctrl_dport_disable(dport_iter);
> > +		if (dport_iter == failed)
> > +			break;
> > +		dport_iter = port_iter->parent_dport;
> > +		port_iter = dport_iter->port;
> > +	}
> > +	return rc;
> > +}
> 
> [Severity: High]
> Does this rollback loop also skip the Root Port because of the
> is_cxl_root check, similar to the teardown loop?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260605003329.2584012-1-dave@stgolabs.net?part=2
> 
