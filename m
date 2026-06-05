Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36C284B25
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626036; cv=fail; b=lDAZeR2h2RfJrkX6DLO7E5kMKJm7Okren/YpfZTsM8pn4g2M+/nf9SrxcriqTsovjjovK6Jp08biM7YRL2MKDAJyKshbDYAGtluIrXI81+W+A/TeqQH316hR2rnRgusNaHV0HpcV1ZBJDjO7gbbVLWHHKnWfahJ2s/KeFHfYtN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626036; c=relaxed/simple;
	bh=Q4MbGk1utkGeOFriZH1GjpDZxLKSZMyIXNYAyJtcnBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMHGGucV/e5lvrdRfCIeUObFSi27iswZYKnBh4Udev/gGqJeOVRkYbg7PKsUyyPdifSwhKlY+QRI3VBr8SEIFQXjvJIACN0lv1JnqONcIj6u2EWGwnvhV3HrAQOosa1LAOP4OtfH2KL6QKzJiypQXrUKizy24iZKGuVVTm1DWPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DhZdvKbl reason="signature verification failed"; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhZdvKbl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT5on1KWwVeayLfP92n5Tf5TBUIulDRwKlDI4SacLAldYGZrwxgdBZqPpS3JiBPFReBp90hEcYn+e7o8gTgeZn5UnSIEu2emaVdWk0edAEMSXFwkchHv45j37JbE0Zv0VUyISD6HDIjrLdEK1O5O9qO0+mCFa5MOsiyN/3+a6LcGzaVIyo18RbUe9VqYb52vdn9AtYV7iInZsMfrYmA5S3kCe8/asgDYfRFQDJxV6fdRryuADJdakN8YWmK1WoAtVDfWT6J+37KDDwhYx9tysM3ocJRBFt0RF6B4JtCFnfx/hqVAgbSKlvVFn+A8ToPQWbq1Bs5Wg6ut8Z2ZWiVRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6YtP6ffuh/wfOqLc2tfiZNJgzjdSJhSrTMkg2NM538=;
 b=jqRn6haqxXN15c5rohlH4w/PVjKcPjUzpoY78wZb95Yh1pBUQtPwsVzuYV5k8K5Cio2A7pYMUyf4WdS9P7brnqSYHREfVrqLK9PcVR5vJWLPPOGRDg6WK3kWX5OPaWJvI0n1WKxDyWp4SG0ivjdWPzlgMk7I9yODtnkE5Nqi7Fqza8547ttuymzPabRyUbIwPWv4wjjt1ozt8oWPJG1E0lwxstDT0sqbtooPfZ31UAj5oyJfInao1cdXoD95jFBA/DA5IMl4OvbQ1LiNXmTdX6GD0Wh62CO7njFe6RLc//OSiTTSytAfm4eGDgW0hXa3CDJHCQGVTu3vq3ZLh25dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6YtP6ffuh/wfOqLc2tfiZNJgzjdSJhSrTMkg2NM538=;
 b=DhZdvKblhgQjwhmEyUoFzEcAMDhMmskXYGQdq1GfePClRK99YhUr1McJRHEl+PoCU4i2Q/AvYOXzTHG9F5OuyPPQbE43TmVE8z1BVL7lNaO4tdD9n7Ui7yXBiu3KiGjfNxpq/xJjnNGwr5IcVLObSF7ArPEEz0zKeycAsfDfmRBjSvZ3Hd5Ed79LEsvSH2OEK035iJWuyPN4HynjDQI5127dpgUZn1yo40wkJyMtxYcwFhYAXUF6+hwCm/yc7Lc83l73x0EAaX7X96YpN1UW6+2MMPvzEcqenSu23Q7dzjf1gIEPjIYjMiVMRPNayU3klj0YuoRigDrH74UYadEXvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 02:20:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:20:23 +0000
Date: Fri, 5 Jun 2026 10:20:16 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <aiIwmkvqVGb-Tdvw@MWDK4CY14F>
References: <20260605003329.2584012-3-dave@stgolabs.net>
 <20260605012940.1A1EC1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605012940.1A1EC1F00898@smtp.kernel.org>
X-ClientProxiedBy: KL1P15301CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 9858a4a4-b784-455d-495c-08dec2a8ff64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	F5v7aiFw9XoLZnllXeCTY+gGnFzudstnMgYy0VSJm0myVymts9BsJtYTrZjbHOoZLRhVFabY2FZj17lobaIQnEA2SFBKCqG6FifzpW5xVLV0tNTUwdycyMJXKZjta6bmIsVsUcp7fprxhanBe76PVdGeP9QMykH6h4V0ZMPfk2wqQdVPLiWOCKyFa02lGw4B3xAOgw6e37oz5o79KSRw9ISQEatYV61umZawwHAaJv2n6f27AgFQPbASSLuwoO+ALMtpS5+w9t/J78I9g70iqwP6Zy98EaOWB/GQ6KrRsNBBh5kZISsQ+g7fW/GD0ZmA6J9anXQCxPIw+qEGye5zXCc1XNSj+hBu+SQjZhcWzbQKsivS8LDJAQmh//lpxCUrWSArvAMIzyVCsJImOY4VHoHbkRrGFXbITjIVVLOq/TNRaPQFjYbrJDu5lHaSOdMvovWL9DU0zilWA/HMpRe82lCIHfaur7/vuCpqpsylMhFoVye7QW3VZO0avnEZkk9fCB0ElauWmWqk3CxOOOIZQUVEAn3PxsAirSwSfRAZPkbScJSLYohCZo/XKGk/5otu0yi0Bwu8/Nye/Zodcec65q5RleyQCVOzXJu5sL8EoVFfMxlPjisW+PxcYmHsEP7NIjghNm2fcp3/u8sRlfGBLGKj+bFflmKDIMl61Qlx18YCq588smtDV2NPMaQfeYAf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?QwJ1+aJkMqL2mmE9cn6vx2JzTvEFviQX0wZvPfewpsjXbAPQlX4SA8625r?=
 =?iso-8859-1?Q?4UYdGNugC2ef0Qw3F/CMpAzuLBxqlJhmJ0wod6i0mmeBMcAcH1e2nw+3Us?=
 =?iso-8859-1?Q?SsmbAuh4IZqb8Yc7ZYIrfyUuFrY22AJ7ZOSKhjVXEEGUszogKYtaU6NR8g?=
 =?iso-8859-1?Q?QLEWY65TlAzSbw5LncTJx6/f81dPlX4I75k8ieVW/TL3GXfVZyP08UMY4v?=
 =?iso-8859-1?Q?wvvG6IAHTY4vhnLgTnT7Bp2wb+Ks3Gq7evY5mVqx9Wfyk6C0gDD8lhST8T?=
 =?iso-8859-1?Q?G/KIx9U1I9sGO5wZP8fvKxb9Y8+7yBc+HUl0GV07N/7rxUagtyRXcy59uH?=
 =?iso-8859-1?Q?dQWRV+kf/OtEsZYRWSBt+m6DYMNbwJL4huogCYTv6DzKQNHHKHTfS+yLLI?=
 =?iso-8859-1?Q?mLoAnIbzaQ0MLgMdMTF8pVims04AU5mirSH1gVohbSlB1OQIAkl374dGQH?=
 =?iso-8859-1?Q?kEJ0fEHgDHUVPMUxmRDiZ6kEtwI3ZrUUrG9M9019BVKFshFbE3ekkw4ZA6?=
 =?iso-8859-1?Q?W6TM27wwSJUFfqYwZLop72M3b28UMC35DlkbaOW0x7AEp8ocrv3ivGuYqr?=
 =?iso-8859-1?Q?fX0D28aaJRs9DfwVwTJdu5IFZ1eMKSJMg52BY16kmbyQXg6XuGb6+dNAlA?=
 =?iso-8859-1?Q?rbxUtI+rEIgXceuue4ZTY1Wx3O7KkHncQCPacCalNV6+LSj3MmuKQgE5EZ?=
 =?iso-8859-1?Q?L30jpY7rQYMyMPuxgaSA4m7jQ++ssepdjZA8WDKPrMjbRSb0pA7t9qHUjh?=
 =?iso-8859-1?Q?OO0u4RwCwQp9Nj1rNVTuc4WLjPBiQt1pagVx6Jp6GqM0iDNOxrcKiQhyDE?=
 =?iso-8859-1?Q?Db/rSpIOUrATDELEizeKRPAmP30RFgMNXCdX6EJulYQfTF4bKDJ3X0KXfQ?=
 =?iso-8859-1?Q?zfuK/X24GMHzBEVU4ovRuaf3mrddaCU7ZVhvynFGe8NZE7brsl2tQhw3rI?=
 =?iso-8859-1?Q?4zfpIzXa9RQdY2M3XG3yh4Dpfa+R2ktvlv4zF1KsRkQMdCdrZm5QDO1oRD?=
 =?iso-8859-1?Q?MDKf1lk7b6e9GQwv6yRYSMuBWYWYvQVq5jaU6lN3Rdbaol7pwbsKq4Q5cB?=
 =?iso-8859-1?Q?IkJlDz0WAsvCpB9M7JJA387Sqv40QHCb1iOXVFbRptWeF8HgDO67KmPl/u?=
 =?iso-8859-1?Q?S57EYMEFtJe/FPWTl5WJBU/GKhuE6k2fwrvYSGseAf3VE43sVtmSxgwOt2?=
 =?iso-8859-1?Q?cweHp+9UjsEjCu69jLe48HJmD+bLlyXxkKs1Cayn3BUN0lGUfhKq9pHD/L?=
 =?iso-8859-1?Q?xLBG8EbFwqEjEKWhZGb7+ZB6/Vbn+WfxGk7Uh+tWNJKffrxul8sUIVbj4d?=
 =?iso-8859-1?Q?7CBS8nwicOGkW7H1tWmOSjP88gFl4cYWo7NfUvUwg80VfN0N0MwcoC1HhH?=
 =?iso-8859-1?Q?XXDXLbVX4HTRAtxf6wkDxAB282I0FFGRLzMCbXBsIHVsWZMs52qy5M7Y+t?=
 =?iso-8859-1?Q?MmT6IPwCb2RngEI0VwNA9BuT5NDUwH/KAdCa4OSLqTHXxiHzt5eV4MmGRR?=
 =?iso-8859-1?Q?IN+T4sMC/FepXBda8OcPClxpaxgqD0S9RSH9AaQKnx2g+LCruYWQVJsWw1?=
 =?iso-8859-1?Q?9aVcKmnO6THvMDFqfi923D8tlCukGBULFbAhuCSDeeJTMydeZJJi+NbO7c?=
 =?iso-8859-1?Q?EF+qg0AwlMVqifrGmJquz8TbOcY4vQGXz788OMVPU3MIkdLtkZASNvPdug?=
 =?iso-8859-1?Q?S/+68EYjv+M0EyNnfkdyDXIxZEGEwGDZwCxfjOE40mYdek+G6+Kj6Umr24?=
 =?iso-8859-1?Q?TmF4ywdo+L3//tt77j/NdXeDoMTQMIHwUPqktO/X5hOb79KQF8lq5cf0ST?=
 =?iso-8859-1?Q?5bTpfa0CrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9858a4a4-b784-455d-495c-08dec2a8ff64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:20:23.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k468TDfRuyPZhLD6C9WWdz0qhZH6t1xlOdEZ6l20OeXjthbI+pk4/FYLuFFeDrhwUBoI4KnPoi57nZBXXt14iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

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

Yes, if base is 0, "readx_poll_timeout()" will never timeout
and thus hang there forever.
"tmo_us = min(5s, 0)" will result in 0, making tmo_us == 0

 
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

Acked on this.
We should consider this situation.



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
