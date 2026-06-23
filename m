Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C83C4B93
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201749; cv=fail; b=qr26MC4hY+wt0a/eeFfH9wOJ8F/wKG8WrXF2rfQ+c6rSg0UI3X1JLL6DbLq61DbUEr8Vao9iOJmwQjdskoZmjdB/qtgw4RUme1pFEirUQL0L1Ad9R7/H1C0xobGalxJ/3Lfj6vHJnkPRKaIoE86kzOmeQaqX7IYqy6NGVY1/mK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201749; c=relaxed/simple;
	bh=wYNFmmNI4JGqB4eO8bvnWS7ihMM1J+OdgViLNx2O3ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sUrzt762vnrJt1BN5qmY2ezjmu23jb/xK2tvjYg8osm+qAgWE9fwOIekBkQkYmxAxMP3HdlgcdB7+8VydZsk9zB3Ha6d5WM9UScM5bLOPo1sGpjWj05d9thHnxQp7MPFwGt/qq7CrZ9MRaGEjjYNFkVr4FaEFW5GQ6n+5D2BpQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hd2G8sA2 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hd2G8sA2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH/LszQdxKQ2iMn2uV3LF0FFFpJHrieF7U0KAIsaikEDLCNkPWbeXI+Q9jocsmV72voGiOtjo9n6o3lPbPQLDcH5nslINw/VHoUEhB0ZYpunbpGP/mnFmp4rTtkVJRitHalB/50W6oByozLbAs+o2w/G5agAn5SOn/64RnPU++sKf1dZ/+Rc6zQaBuY9Pk5c9GGzSvsg/ZqyrfHZ+ZCHE/SVvMfoMX5Ea7nizaG/C324PbL/s4/zhm50pYMYRvHLR2an+Pw7Nd+1j1eKSyr7kgLMBZnoRp2gT+VsPViE5Knu5YDZf/SigypsdKPo8f7n9wFzsA8RIKp/KJZI1j4E8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld39UzQQlMXSGSpOdyEPGWKZwIpVx2399ayY1DWiq6w=;
 b=Ut2qiiMWFrhzXoq6J3T1qJCL6WZMxSO8uETuQwSaZlUtGuEvbKTd72ZOjzJGw95nvDiZWp7vgGdJ9sSQT+8nTGVzS4DgdahyTfR7dCYCnP2eoSSyTQJF5qwgs2hXNo3CNfoGPC7M5fHJ+m/RMM91Ab6a0cAzyaf7Jeo0/noFO+etW9G1WbtbyzJ+PjzaB9umCwt8eMJX9QNMe9Z0h2rAUtZmY8z95FT5GMk/ftjlIa2RivzHuio/ZInf0kpFKRiHxNwYpfovm98EHuppbnZkLzP2Nm67KuO6i3aP2b033iUf6uYpXuNRRiMb7yR5PI0ZN/zJyGfHkwbTyBJPYVNLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld39UzQQlMXSGSpOdyEPGWKZwIpVx2399ayY1DWiq6w=;
 b=Hd2G8sA26bzgEyfRESkKWB83KrVLMMFJ6S0uiJuW46Ks8rYLQ4DxmTC9bOQOanYNwsurKKSXlVcQPQSVYQg3o7hVZyI1eYiEr7wxMJHfa/u1x6SuggkxrxhwdN+v9LE0f8ZrhkXfYTVEXiKLgTHux/a9LDjsDV6/d2qamnn+Uny6EY0EtR4+aBdxzLMd848p+0/mKBwjqJ3/vHUoLIM9L2CTD1NHbGIKFDrTJpAEl9RFp3Pw+w7V6zLx9mbQLbxiBsUqCP0mXhxr9yyj//0r2tEQmEdAf7BStSOyzZNejzSAL553dr7NAwId4fuNLLXZUgyHkEhdy/fUCPq/F7Zu9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:02:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 08:02:17 +0000
Date: Tue, 23 Jun 2026 16:02:10 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 1/5] cxl: Add BI register probing and port
 initialization
Message-ID: <ajo8nZVglGsutdpg@MWDK4CY14F>
References: <20260615145529.13848-2-dave@stgolabs.net>
 <20260615173541.BE49D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260615173541.BE49D1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 232d2ade-3c81-4e44-83e1-08ded0fdbe2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|3023799007|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n20WnLiK/W2t7lumaEqde8DaWiKwLeAJZzYiHQsY5bVa+ZOKPx8dImU0/jsy7Cz2A8M7iNXUiIO7cr087gu/ZLQOTznCu6EiezR9RJeM7qGuyWadTncQcnWlqj3VYxNYtkAVnWFJj/RKYkbjg56SLdOucPB2sz+P3q4xrw17MMz5BMVkG/2Z0TjaDjMdRRD/opjifQxSJvkYK7zj1y6rpCzz4spC3OHMFttCxNXkiBOjPiIVS7VEVOOmz36+cmTtW7JlyO5ua1LpmhvIBrhd3m0lVc9EIaxfjmt+//6WCjLeaHEGXZ9muyZalWcGYRKKNleMHAlraIzj8FvipGaGReZE1H/D7Ornq9GqNWiTe2pI0BbDj3Dl04Q/LwPhJOeL2X28Va6LB6L1eSULjrzGfVigWdJ6BXyNo82rk7sM2QbvSsTr0IUFhdIJkWaXVOz9SXAy9ve/S8T14Q4fXEAO8DPeXhnrgzaAj2Zg5lC89NC2xcLCIa7JdK5Lfd7KFC7uOIs0ZTdQ2ZWUKFLeFSdfuILNrOdVachlEngMEGA0FbH9qoDxM/vaVT2IwLI0NOEWgTaLRYLYL+jGW3G6dy8cLLiFWx5i36b5BUps3R9c7pys5dCAyedkF89589HVUUZksUGyKKlj5Ck6qIBZoyiidSNIfvaoP4fiSTMW/71fKpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?vYxAX1p/lLUfvlAwJT7OrUfO+0dgSv17bJpFoATcdZYnoUcFj4eLPoT7In?=
 =?iso-8859-1?Q?eQ7sQi94072jWz7092AxqBvAQuQEvGVeejVdXztiecveSD8YYftQP/iuaa?=
 =?iso-8859-1?Q?xy0qp40q3QaRo2KzvKpg6uJc33zbgzd7kcEetr/KEnWL7wP0qmwhEJO7tt?=
 =?iso-8859-1?Q?LbF1H9mlNyT8xDjN1Vq9rzngOvL667HtrKv6Rg9qFhgi8EZZvfv0QxYrYE?=
 =?iso-8859-1?Q?GOuZhhYqXxv8aO4xDGPUwG8aCtMLFoo2kHaezr3C92uWAw3fIz37ZwSGp9?=
 =?iso-8859-1?Q?kwHadIJR0SJu/5WsaiNn/1BKkLfn9GMy2adNy2pdIkQ0Dl4s90knAQlK1E?=
 =?iso-8859-1?Q?Tdgmuy77CBWlBgSkENkqztLuEEb8m/STIGWhnlY2YJZVxxsJm4ymt3qHXi?=
 =?iso-8859-1?Q?jZcRR/OmkuyoLAYNEUz5683mZNxIOwPLslV8oWbgRz7NDE6yY61ZSzz2tK?=
 =?iso-8859-1?Q?ud66AuRDsPhqri7JGjnOdmeNvnHzOPq9Q63ZQ09e9Cg/9ZyQhpYw8Inwfc?=
 =?iso-8859-1?Q?xRlft6oWAywo3n7NBDY0EKw2cE6r9yu3z302aQCENE+GuLiZUzzMhgWz/a?=
 =?iso-8859-1?Q?kOBFzZ/eNDWESSFVlbyFKbJLOgEB2VzpLHqBMBxTiRl4pHhfgMmXaLqJ03?=
 =?iso-8859-1?Q?l4l1nDmcKOccuFlKaPkhXiwkwSMRSuUBAiJjzMlLYG/ZmbbfwJu66w3cnQ?=
 =?iso-8859-1?Q?BHIEzaUXUVV00pF5EFQ4ioKB6oBpmruDTw1fwKS9OkzKM8aT3F+iFJ/1BV?=
 =?iso-8859-1?Q?E97dvZucBdBSNJB1OZRiUWsWYVSP81ujN1Zxfnvb0xtqqXf/TsccvnUkJb?=
 =?iso-8859-1?Q?uNyNAA+puVRBlV9gyvPToOCQhpIqSJ8uKmz60bf90o91yhQX9U/SpqeZGT?=
 =?iso-8859-1?Q?MhBAbtwtRCMfukDXonksOUzfRNFvHThi7+FtY0U9xhYW3ryy9gYvPWjZnA?=
 =?iso-8859-1?Q?yJMPPBXzgry0bIeup2SukbCafF7+J/ozRIhp3Pu+jNdoh/tPXe606mheqw?=
 =?iso-8859-1?Q?rz8CzzzCOuKP1p9qZ5d2341J+QiMULZJlwuun6TqpB1sQBgY7fSdfL0o4e?=
 =?iso-8859-1?Q?kRSNhcqlOTIN5wpAG3CS1iqy9VQmCUV5h2/+HiQelgP/tOyFLxKSwlqV/9?=
 =?iso-8859-1?Q?wqE+2fSYSgjKlwheYFspnTT75ZOBBTx4Lj4R+fu31VC7xwGofS1xnBAyW4?=
 =?iso-8859-1?Q?PpTlAGAic+W4Jp/yP6NIMoJ1H2wu0YKaxDrBQ+fXYv/Q/N5SmB61i/lcQ1?=
 =?iso-8859-1?Q?sKcdh6bCSD+r5UYGY6dDmSQahFT68Q1q7Ab4QSvAVv1LLpO5pmZHLUbHYZ?=
 =?iso-8859-1?Q?oO+uXyf2F3lMsq9UxJxpkAop+fOsqJPMnH+iKmC6ftetZpHgzI/PtTHtGd?=
 =?iso-8859-1?Q?/C8EP5B+M6/PjsDk3mZRLyNAG16nfUfiykcqHCTjcYrUjijqrTyK9wC6iO?=
 =?iso-8859-1?Q?WBVmn2Dl0BQ4E+5Au0WvfMy+WTtBkEw4DzmbsaXSwIkQ5ZtdxlEtnqBqf8?=
 =?iso-8859-1?Q?b1gAzrMNet5JVIdZ3QSX/sQH7uUq++nFq1q8R0DgPr+jyZRfzfbcu7lWpR?=
 =?iso-8859-1?Q?UaobkRILcFNva9gwfZ7oo/MnV/EP+ZOaKXsqZjKSXpBxRzsdV99V0KG3OD?=
 =?iso-8859-1?Q?b6iDmJa5qTaj1fgQaYdCa5TzkjzLRB9G2swx3kmWSKzQ4EDzxd//ZAXSKp?=
 =?iso-8859-1?Q?Sae4uQ8uTH76D6hAnivzwUKbiOGI52+mxfiiEFo2mVOYn5UozVpzhGr6ip?=
 =?iso-8859-1?Q?bj6MgzJCTYUYPC6ZDN7vIvYFvm+HAqjnTsnkHIptueE4ek/mcMwF3pQ6lJ?=
 =?iso-8859-1?Q?lfs2uznlvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232d2ade-3c81-4e44-83e1-08ded0fdbe2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:02:17.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRtw82lMpkMpdN9QTxL/5YJZzS/nfKw2vqON7PpB0KDW5xk4xKst6RucQPxLqjeyKaYwBf8YSKNdOPJCO//fqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

On Mon, Jun 15, 2026 at 05:35:41PM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] devm mappings for dport BI registers leak on hotplug due to being called outside the dport devres group in cxl_port_add_dport.
> --
> 
> commit a836080fdf13fa334055f7f13a95491b66ef793f
> Author: Davidlohr Bueso <dave@stgolabs.net>
> 
> cxl: Add BI register probing and port initialization
> 
> This commit adds register probing for BI Route Table and BI Decoder capability
> structures. It introduces helpers to map the BI Decoder of a downstream port
> at dport-creation time and a port's own BI capability during port probe.
> 
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index ada51948d52fa..ca8d8c14b7876 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> 
> [ ... ]
> 
> > @@ -261,6 +321,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
> >  	/* This group was only needed for early exit above */
> >  	devres_remove_group(&port->dev, no_free_ptr(port_dr_group));
> >  
> > +	if (dev_is_pci(dport_dev)) {
> > +		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
> > +		case PCI_EXP_TYPE_ROOT_PORT:
> > +		case PCI_EXP_TYPE_DOWNSTREAM:
> > +			cxl_dport_map_bi(dport);
> 
> [Severity: High]
> Does this leak devm mappings if the dport is hot-removed?
> 
> Looking at cxl_port_add_dport(), devm_cxl_add_dport_by_dev() creates a
> devres group for the dport on the parent port's device. However,
> cxl_dport_map_bi() is called after devm_cxl_add_dport_by_dev() returns,
> meaning the devres group has already been closed.
> 
> Because cxl_dport_map_bi() calls devm_cxl_iomap_block() against the parent
> port device, these devm allocations bypass the dport group and attach
> directly to the parent port device.
> 
> If the dport is hot-removed, the dport devres group is released, but the BI
> capability mappings appear to be left behind. If the dport is subsequently
> re-added, won't devm_request_mem_region() fail with -EBUSY due to the
> physical address region conflict, permanently breaking BI capabilities?
>

Hi Davidlohr,

I think sashiko-bot's is right on this part, this part runs after devm_cxl_add_dport_by_dev()
has already closed the dport's devres group, so the BI request_mem_region()/ioremap() land on
the port's devres list outside that group. On runtime dport removal the group release won't free
them, and re-adding the dport then fails the BI region request with -EBUSY.

The dport RAS mapping is done inside __devm_cxl_add_dport() while the group is still open for
this reason.
I would suggest mapping BI the same way which is to move cxl_dport_map_bi() into __devm_cxl_add_dport()
next to the RAS setup, and set map->host like RAS does.

What do you think ?

Best regards,
Richard Cheng.
 
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> >  	cxl_switch_parse_cdat(dport);
> >  
> >  	/* New dport added, update the decoder targets */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260615145529.13848-1-dave@stgolabs.net?part=1
> 
