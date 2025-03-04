Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2727C850
	for <linux-cxl@vger.kernel.org>; Tue,  4 Mar 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109062; cv=fail; b=W2zQ4vBbk3ePhsYpLEyvETR7If3DcIbuA3TSW/4sERA1TxaslmbKBc87fe0T53j2bq31lRrE8Lbol/o3wF9F6EhBZXDy/HdHxUty+YrMYE6avn/sYQ4b7MBJ5SzAagSmfzlu2xJ4234HIkEclM53nx6k8lmovoUUbEeDTvSexYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109062; c=relaxed/simple;
	bh=nws9f7w1UQETEasNV0pcUKtW94MH6JvFiJqiZTyMiH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=idaSdX1Wr9qYsocIwuymvsQktxSyd9iy+lUBpWrHlXCwEQ5mlUqOKWBkoNlBysYyg84yLaJYRpUDIvNUq+VCQFwBPoDIgDakWNHNWGkRmf+ILqCKggNxV2uGZXu6LHyek4r02Cky1jAL+2rb84E5swIIoVWef7cfFAaylyT22WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrvCQky7; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrvCQky7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tq0qjnDmvUtXIbiDtStUrnuJKTD1y3c/yGMWRL+YpmhFcswiIaRIrgaS1urHf1Fg6AgyhVJERZaD0VOmhlkSxMW+obIhcNAv8k2RDk1a4jkSyKmspvr1EbZsDCteYYZrEO7vXUpTsrql+pbKjcdXKa0UFUW9h1E4a2pymOFSjaoDbXxQI8hlB61WY+nCxdOWvi8Qp95kVI6on/+VR+z2tEu6leP3M3M2UbGkR+BrH+l4KVIRvpfsgVO/T+Ly3QkqLRa3VgJZ1wRRpByXkkT60sqVAOmJ5zdl7NbGfHTmnLq0xr+pTFt9i3tIShQ+JzPqum8A4bzd0k7dUta07uyv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqwcrAVeuZWSsTTbOyO2l4835KGCDpN4IKGpOFkzjgA=;
 b=hmE9MvzMLLesClYqBbCuxbJqhitUnSLWzjt8+WvhIGD7QbMDWY6Dsr4Nwv7fZQi56Wix2Lfxro0GZyDPPUFO6gK7M7rdmzm5p/gILX+8LiSnWHh7i0k4EATlJ5yrpbpTE6U2lg+PkaUqfsNK54OyoUMmy7oUSj3RnkVY7gpmMvtOaI0PQo1MHOGxFMlBPIBMf4cbp2onszbgsEEPXk6Zm5Ir00UwTeT/MltOv/c0O9RuN59Ortncq+T0LDe/peBYxqWxRspXcm00Y0OJ1o3fqkyn/XCETvBMU6lcM53GLzAlrnn9arJEKd6uPmNkXXExoHFgjVrji9sFLUgw8+7iWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqwcrAVeuZWSsTTbOyO2l4835KGCDpN4IKGpOFkzjgA=;
 b=mrvCQky7cZZjFuw2gZRggH/dKGxh6kwykYUgLKlX8dSz9XW+s1Qh6h0Dfff26BVau+bTsVTo9S2PrupXqVXjH2Qwc5WHvJLGd2zUPueXZMTAuXQV81zB7TVXKO/r12Vbh8lxin/0RqZNIy07zanzXnvWkBV7CY9U3W6rBY7ovn5LgZ4NhAv2wgoOTYKlh6wx0aDBKl1TJn+ZPr726RlOeFjlprAEDF+bUeTX0F2Rd+zrJaExPBiMgjnJk/0qR2jyQF5iAt1x8ApKDkdknRPvINwVBbG507wIF/goPc+TvpXtoxaL9mCP99Mu7ACS79NQ3RDXEU4m5Frfl9KPXeVJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 17:24:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:24:13 +0000
Date: Tue, 4 Mar 2025 13:24:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, kuba@kernel.org, lbloch@nvidia.com,
	leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250304172412.GO133783@nvidia.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-6-shannon.nelson@amd.com>
 <20250304170808.0000451d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304170808.0000451d@huawei.com>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9ae1a4-fc9b-4a93-215d-08dd5b4161d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcAj9E4O9NQP5Ge6S5EYcnOVE8QppNScaOCuM8572lZ6lCOxBbazwm6MHdXv?=
 =?us-ascii?Q?WMzCSE8YecaIXeapVhNRCOBc1pnmsHUvojiLqpPrSR04MBFuooCX85/GooLQ?=
 =?us-ascii?Q?wM7v8sDklQr3J5bYltPpmtoqyT/vXrb2G2rn2rY+96v8zX/Zx2sfanccOGCu?=
 =?us-ascii?Q?OcrCvNuM67qm0iATvlh5xZRhHM/6SAFlrHnVyxh9FH9JXP8vWjLtDdHguPb1?=
 =?us-ascii?Q?dzhMeUeu3yacxFNMa1V3KxcUt0nG1BH91VUhzhH7HtdbS1AErvcfidsnwZGN?=
 =?us-ascii?Q?u3y6U5qtKjY7N37JEasoXmolhcPrR+Duqe5JrqeBCLc73BeKU2EEYLTx8M+2?=
 =?us-ascii?Q?sXLR3ExB42Zp75x8T2//KczvUOA6P4nFUnzz30+ZG66w8yVrilmnEu7UvbTl?=
 =?us-ascii?Q?k1DpbaQN5avTLkNPtqlBNHBI0hreEUX8X2WGL5nV+8g1NcuhRqLwaK5uCu1S?=
 =?us-ascii?Q?n5DgsdBhZgkE8HfYahPYeOEK1TgpGMvzZyOzFXj0xoplGBiHVqOSOKrU97ci?=
 =?us-ascii?Q?qWHrx/OOXaKktgnGUEVMSoBdwgSY8slcigaFPd7oLai9gpObuWDCAzh+Wc6T?=
 =?us-ascii?Q?agOZO6YgEUybh3mXTgZqzL0u51DmkWQhU/RC5X9OPr/+SyD74KZ1wCQjK4Qo?=
 =?us-ascii?Q?Wf1m2Yck2F/vVD/xMxyLM6bK9yfKH1M77+Nr08TxXqhWuUq1kX8+SWqcWwvu?=
 =?us-ascii?Q?yCqeCck9tca9izf5sWBvKlvG2ZfhC5OVmHwD2tENsy+jWsMhBr+l4v0Aubs/?=
 =?us-ascii?Q?T8HOZLpNDjGeJ4p4dF6DN799Ds4kbdVcuFFhA8Qr0c3XWt6LbkmTHtOaqAle?=
 =?us-ascii?Q?K66EpODMYhFU7cOtw0jk9S9074L1Z5H7B6hkJF0t1uWlFnfWYqh3rx0K4QHu?=
 =?us-ascii?Q?ZLJb7+HcNsuxh+o4QY0yseSorVdNBic7927rx3SNdPOQzeRkHOzJWYJ+njkI?=
 =?us-ascii?Q?/6V4UHUWwCiQQOaTPQ/cp4yyuGTBhZYcwMMlxJxxa+S/pbvXN4zcTQx5V/9D?=
 =?us-ascii?Q?uXWCQRaRtnVA2m8CE3hRV6y7JVWxjh+xCaEDbRxI8waIRiW5CupEGB/MB/89?=
 =?us-ascii?Q?DLY4vpEu1tnvryZ75+HnSNMfwbTWNrblYWpZD5fZe6YldBXfnYZNEpXmbopg?=
 =?us-ascii?Q?KGhZAzQlI1af/dhd78OBRIXiB6Phmz8NLY3UQSi6gCNB5Bg5UOjKwVMS2ril?=
 =?us-ascii?Q?W+t6DL8rhUwp0KUX60xHIdtg7uo/eqSHTkAMqRlTmAZzTyCD6HlfP4XSVBr2?=
 =?us-ascii?Q?vKFJnFqu3R2ssEROoEa0YtSKDBar1r1tLeb5xFwsKvv7AVQngY+rXIuPL0h4?=
 =?us-ascii?Q?RtQc6+NIrckjMKP3A1Gg+wO+Sq1NNX9qOl/cn58XiwT8Z3OJNdQ6ynF7mCFN?=
 =?us-ascii?Q?iBlDS9seOIzgJSJnW/oTxZnVhZ9i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mfRHEMruTM5UIuJkgU3xlvwjcAptTffSz2jD3zNa7xhgddC2a95eZD5HiPsQ?=
 =?us-ascii?Q?dqBXwqq1rfCJKdQnIJ4TneM9j0te0gmd8jxTvj2Brx+KrDoeeZ35HStyy4hp?=
 =?us-ascii?Q?npU4OFip7mT26hoUZFGpx+q118Oul/6l3wjBm5190cTAws0dvZyD7EwO20ne?=
 =?us-ascii?Q?L3GE3Q953pZ1mBheIYLy/mh6PI7T8PUN/o1SqZZtDNsULKjky9yl2qH9hsnd?=
 =?us-ascii?Q?O/5gSNKZi0fM8Dn9lPyrVJz7L7Nf02jFh25SIW4fiNgcM5nLXMuN6GWZV2UJ?=
 =?us-ascii?Q?n29bLPRLewAP24XexH3ma63ouKDxNxytDSo+/ebTzBjQvwGX/VfLW3J1svdJ?=
 =?us-ascii?Q?hCn4FsKvv5QgZyAXnEzwyWxmkUJAqIsfZegOb9YmbBrf4BHF34yVYRSPXtzk?=
 =?us-ascii?Q?4rr2wOno/PZ+0qeUcWUlF5bu5jlulXHryrU3hn6fY+sRmSBZJLb3z2rXbgq/?=
 =?us-ascii?Q?yz+tgMXgd/+tQl6kK99aviKX9AmuKuM6T7oL85ITkVf+vvyxuzCahbOPrP2h?=
 =?us-ascii?Q?QDkn/VuQT7qLoNp8aDL2fLX+oQ0dli3Q+RELFRcfAeP1giDxRam9nUJ3ko6U?=
 =?us-ascii?Q?65VW9qfbROMp5wxrUl8aIdWAZVGICHUpjRZvY9o6UTLfrEJo+tovz2VUkgmU?=
 =?us-ascii?Q?el4n4FnJBdVjZnnfSNninE4g5Ied1YeCQdgsFKgMwx0jZjSl/eaUcOxL9FyN?=
 =?us-ascii?Q?3jSTcS8L4wG303i0LjMj7ZZI20o1AwQsUtJbfbsM46ZmD5VqHXlHTRI6OnEy?=
 =?us-ascii?Q?bECRv1iH3Od2ks7u/+FETBS8+7/lMgtmCkITQuwmkY26QM9nInGM6eLSYgjk?=
 =?us-ascii?Q?pVZTM1sAo5L+X/9LymduOuoflB+Xxi+Z+TQeKNtda1Wt9v046zRdgAKE1uZ1?=
 =?us-ascii?Q?G/0wMvJ1s5PrjYh+5WoHtMUcJUROrp7OWh8L20NbaZvGKoQigcB5HRTz3vcY?=
 =?us-ascii?Q?7OIgw9IMJPpyuzLKFNaVYb/8OFRatGRySWXax1j+eLoXfWI5Z8DN2ViCIWne?=
 =?us-ascii?Q?MlWGXabl3Hq+2o0lT2U02w7mmeVcG07tmqdsNUBHJIAYxRrkz4EQHVnDFPU1?=
 =?us-ascii?Q?DeB35ROMz63cN0Rx4rpugWlJh7WaaFBEOSmmuEHEwEkpYH1JA7ERiJ6TzMTb?=
 =?us-ascii?Q?HT3uMTH2N4ZZxKt9DD6aDxzXxzb8sPvNVbOQnxF1OruaWyokcVTpLBiKmkJv?=
 =?us-ascii?Q?Vi3gLR5pV8vd+wbZKEwrs9B0+VHvPqOmA1T1LpW6b0MnrVammxDFqD7ioj+d?=
 =?us-ascii?Q?0SeSfXFtN8dxdyok5bQL74AMZMUkWVIwzhAClhiHBmxQnq0EB/LyqRCXll8h?=
 =?us-ascii?Q?47e3iSoF2fauMIVPaylkebRLafuNOjomSf4UpY9b7aG7B7OK7iN83TQFOWQn?=
 =?us-ascii?Q?eHDe8v43afo67QFJ7Ud5lNuaVNRp8MgY1JRq8D4rkidH0uYP9DcTe+rVv7NX?=
 =?us-ascii?Q?UI3dhtp+7HH8dy7B32i2PjhwpvSa+xOM0p1fJXCFjcsOCeIME1RzSmJYzTEi?=
 =?us-ascii?Q?cLya9rZZPiIijwfDgzbE/JYA2rbOYsMmN3yzZxy43DxT41tT2/pbiStCEicp?=
 =?us-ascii?Q?/QwC1hEPx59jPVpMvcY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9ae1a4-fc9b-4a93-215d-08dd5b4161d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:24:13.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7e2v6sz1HOVBYTV+1wAXlgl5dAP8+YX4XSgPFDdBC2pSmY+Tmyv9026gSvzLrZg+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

On Tue, Mar 04, 2025 at 05:08:08PM +0800, Jonathan Cameron wrote:
> > +	dev_err(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
> 
> Perhaps a little noisy as I think userspace can trigger this easily.  dev_dbg()
> might be better.  -EINVAL should be all userspace needs under most circumstances.

Yes, please remove or degrade to dbg all the prints that userspace
could trigger.

> > +	if (rpc->in.len > 0) {
> > +		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
> > +		if (!in_payload) {
> > +			dev_err(dev, "Failed to allocate in_payload\n");

kzalloc is already super noisy if it fails

> > +			out = ERR_PTR(-ENOMEM);
> > +			goto done;
> > +		}
> > +
> > +		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
> > +				   rpc->in.len)) {
> > +			dev_err(dev, "Failed to copy in_payload from user\n");
> > +			out = ERR_PTR(-EFAULT);
> > +			goto done;
> > +		}
> > +
> > +		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
> > +						     rpc->in.len, DMA_TO_DEVICE);
> > +		err = dma_mapping_error(dev->parent, in_payload_dma_addr);
> > +		if (err) {
> > +			dev_err(dev, "Failed to map in_payload\n");
> > +			in_payload_dma_addr = 0;

etc

> > +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> > +	if (err) {
> > +		dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
> > +			__func__, rpc->in.ep, rpc->in.op,
> > +			cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
> > +			cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
> > +			err);

Triggerable by a malformed RPC?

> > +		out = ERR_PTR(err);
> > +		goto done;
> > +	}
> > +
> > +	dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
> > +
> > +	if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
> > +		dev_err(dev, "Failed to copy out_payload to user\n");

Triggerable by a malformed user provided pointer

Jason
