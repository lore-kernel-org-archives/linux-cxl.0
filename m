Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793690750;
	b=nSSDgYShVO5ZJTiw9Q+VCJaaPf9asX35W9cVBRJzSIv9S96j38UEoFJf2c1iUbEWc2d5
	 2FYnJ777jrsJ3skjbPfwA2MmhWgsHLuvSIQiJ9EizFZQelUR6sqinCq41R3vLnE2ZGHh7
	 1JC31MHI2W8bw6QAcQtNbOQCdmZWS8uiPLgMPuWvH9XmDICdws9vfV1eEUquNWFyjthoL
	 uH+uCN0XVC+gUEVCgD5bSy4LnsbfDBJr/+eTShw8dv9YsWpre9oEM7F1oWCCDzrdhALaL
	 /XcVGNp89H1Y2bxnj2o/jqxTcVFK/qjNdmVwjlrTJRxrI96DpHELN0uBzoDOOPYWpBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690750;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RgT57GutDSrRhC9ih3b2uBgMYo0e1mVDLav4QwhTiwU=;
	b=oFd7JBr9bAIdS4VGof6W7Kfft5V42F0erMlkyLV1ECR4WK5dCVBCDgH8vfi7xAN8Wjpp
	 XM7p+fLpBrI173F4J3p1Ohb+CscsLE0mKV0C1VWYOp1Eeb3NQB0r2dWTiE+cgAiUJMWbM
	 7GJwhAsa3UADD0x3II2zlVM147MFM8i0hpok2qVmHBoRWGuMdMc2BbeBHAqBeOeyoXV/3
	 Ry690bO97CiG+SJ0ZS8NrHbuOYDPPWU45reEDQw4NIxMmvdIaj+AQGDepzluOK5/kXXb0
	 FkomKgSUi2VL1J+PVLTRlrjd3f4MPfKkE8mHjjDN5vWoHB/rzKDsbELrCAlIuGMRnMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YYoaBWuk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C86606A324;
	Tue,  3 Nov 2026 07:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C86606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YYoaBWuk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5E/mF0RTBGIe6e2Vc3LD/wQJoXtME4CPM3906DSP7pxbTTnXqYm7NtlsdHFSTctq92DYJ4jAthNEVgyJuU5o75H/upwDlMeoidXeT5JQTeGc2UWexZCprfpkk+LAWP+ZJqEKFzd7huqs3zV9lj1G4SctxDRLXxEL1M784i636DhhEEmxSfNvbgxAC7HJk6xDzhAF32lwl0aorl/hluZnsb4V8ji80QmJYSroyrfn1bSeDF4HE4ZOPE03yNonlmOhkXWXnWi92Ga2E0HLFijMm+ZdGsrK/JdSNsVh9xoxqXwtngWZtLYQY8cWFmhQlFA1mfV9/r/HQ7aPxxQfVfpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgT57GutDSrRhC9ih3b2uBgMYo0e1mVDLav4QwhTiwU=;
 b=aQ92HvScYuXY8MXWX0nemSmnpFvcNORs0DVcADrNdSKnbapAZXhzGLU1lsof7gvpzESBZ30AOAFNf4rjnuNGkWC0mT5Go40ZFhslR/rNSSSYXYMLeRZ8g29pL5zgCQbEsTXst0E7Q3p7U9fXdUMsBtLqvw27VuZpxfnBu/clpJSoYUTIX1W06+Cr5zFOuy+7dToKpT1JNM0fCe05jqHy5GYfG79qHem62+iZqVrRN+WFXPiJibZesYpAsSSL22Zt9I/xTpPIphJDVOv3J09TnYpb/JiK2gu+Q9ddSbzJNfokklYO6DcEMZtTRM6ZNezmo9K229rz4JT4QBhHKhDhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgT57GutDSrRhC9ih3b2uBgMYo0e1mVDLav4QwhTiwU=;
 b=YYoaBWukUxfeIwcvcTUjtTc0IP7orsurbJ2GmAOrXTlkDDDr+0q9n9vszxR+KieYPsQcXg1RXO3EVUw6g3xVvOvXRdUTzyG2ipA16o28i0qRpkLrCs657Vo08kKMQ6CyTPxm1oQtQO1kEgqPFlnQPS8Sd7XgkDiIOVPloWCVOjJrVlwz9dqk1uG71R04zLET9eBswxi1s08CCQL+eTXcyTaN1Dk6AJKpqRd2kh070vMD//BB/pz9M4BXOeCqqfBLPtAdvs8PaQZTaP3o1Vbi29d+KoXtronPoIhLWYmV7QzV4FzcO4mEKlHCGpo8VP8cELjOB6CXz7rJJ1MayYx+nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 07:25:45 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 07:25:45 +0000
Date: Tue, 3 Nov 2026 15:25:39 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com
Subject: Re: [PATCH] cxl/port: Unmask AER internal errors for VH endpoints
Message-ID: <aumLKigtuZ43xRUc@MWDK4CY14F>
References: <20261030095951.46080-1-icheng@nvidia.com>
 <83a62ebc-78b6-4442-a097-566b4a2704a9@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a62ebc-78b6-4442-a097-566b4a2704a9@amd.com>
X-ClientProxiedBy: TPYP295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: a9801e4e-36ef-48c4-6162-08df397bac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|6133799003|260925021911599003|260925022911599003|260925021311599003|22082099003|18002099003|56012099006|261102123227099003|261102130727099003|3023799007|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|4143699003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Q1N/Yi1A7DFjAqKeJQrc1RW14/JmR9Wk4HMjsY7VryPelnx5S648I0+o9jv9G6BNzBd7f7UvjAO2m6M+PLL/lx66XeZEJJHiHvNqZBNrz+8+b7Z7Bt/PrqD8V0QetLtILNYyScp81+nX1/R2nVcvEeKH4IMt0TPF4EHkdWwBOgJBp7sSuWDZTvyxG6x9jKqF9bRTadVZdGGaiwZTT85bsRLq14MpkhZHPgWUtxOGMWR4P36QREP4FlIdZPeMDIJq6fA/VPeoK3gqLSM2LdjWJmwoP924ULs0UCiu9Q8p/K5cZURKTQxK0UC0Bui9hvBWryLBf3/2cVWHqBXPlppoRLVzZzIZXURNip/1cHUKCeMOKQT+1ibcrBvmdbL8wZaVmwSEJD80zYxZfZMPALGDrvu6o2YLUtckxbW3W5fZz7LYKgqysOs4y2myt4FIYxpz2zpCYVHOW9af03JdBSDOeJiXIj95gqDMtPcyF2+7n/i5R4iHa5by5fo3eIeiZDvd6XRLnD8XL0s4Yqm/Ts9HB8TZlGuukPdGLYBB/Zu12F9ZPKKzqsNdRO2KMOO5wAKuu/xHlb515PcIF6ro+Dv4mKGGcx3SQu8+U9H0Vcm1cQPlV7x5jqvLx05hPj5VTErX9k476eACPpNibrKnJyzfjxmvzA9FnQaOGg5pB/emJqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(6133799003)(260925021911599003)(260925022911599003)(260925021311599003)(22082099003)(18002099003)(56012099006)(261102123227099003)(261102130727099003)(3023799007)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIj8PvZY0jVzQ2y/OMNvMnzX9+oFIGx2W8JfvnkPNyIuA6RZTr9mDnTM3NyW?=
 =?us-ascii?Q?vomNbwYYcjkKU7VsCc28rpa8B7VufIjcE2iKEAeyJ0JOWtodu62nJUi7kmn9?=
 =?us-ascii?Q?/vb7ve8+TkPbF8+XcYShJzmjlWAozBKrCag2K0eeHdFyzi/2LO4aNJjkxGkD?=
 =?us-ascii?Q?CIUCUt3xEo8xHcAI3zz5g1LvKH5LtyPU38CQ2YXp1lMWny4P88Drov2ef7HN?=
 =?us-ascii?Q?1j5d05kONJKdAjf36OmtodZuLRypSYUajp7oBxnaVkrfXhB+XP/0OUfnd2FP?=
 =?us-ascii?Q?aAYywIc+sDm86pkQKYvKS+B6HIJQ2/Iw1wdE3gsSgmlDeeyf3UJOok/5rgBu?=
 =?us-ascii?Q?lNskbxNEkF0xPHZlPVNhFfWUe2jR40V4w+fPezQCzqwK1txBPDEtr7rjAmi4?=
 =?us-ascii?Q?3H4E/qvpQDR1gDWw7pKD7DrdSTE2S8mmZ8Zr9IqpovyYW8YXwi3A8jGviybD?=
 =?us-ascii?Q?UycCdAqQQvB8eJFZLKzjYXtrBTXsWRZZx7wM55ClClEpuDnpYd6QIiY8kAhm?=
 =?us-ascii?Q?M3ASfvXg8Dl8K6sEMhWymEHC+aYNQvYrNmHoLOAjEgRwoz7pfkQuLC/na+FE?=
 =?us-ascii?Q?YPtpq4g9e3jx0k48vWG5DkKf1x4a8NCefFlXXFO824fJM2MQDY3PO1qCm3Te?=
 =?us-ascii?Q?aHifwjhHYQ3plxbsL38eyF72puNe3Kw0gpWuKNfdsAncG4uPJwri8QZn61ip?=
 =?us-ascii?Q?Q+cR5GmUPfwORXlsjGyms7qnfHYMTm8ltYglBcuqQwI8NBYTxNmQgfr/Il8f?=
 =?us-ascii?Q?zeW9hGzzom/L9oUo9ioz8E1OPMeVAEGts0+xuPe0o2uVNAMr+QRTcQUeYeld?=
 =?us-ascii?Q?J6+FJ3YIlzDTU+6v+yOf2rLJm9wo76NlX2xhVtxfOAIY5uRvzT0JAwEe3VvU?=
 =?us-ascii?Q?LBRgQo/3NO35c1BtGXiW9vH9ji6ZoAYnDfz2G8moU3G2S++H2KAkpPma58sG?=
 =?us-ascii?Q?axD1yWYjOxzlJISOo2MD+NKOLenrbCo5SO2JejYDXtRfoQV6BT1v+zZaC0lj?=
 =?us-ascii?Q?qV1MvQnQ2U3x54vLMio+EZ6RoCwydWYin8JnmCl0OzhQQF3wUnZrRmfFc6lu?=
 =?us-ascii?Q?e/DlMNmMNnu1xsmLNMqTmfPsxG0ncwXqlIwnFXhb/OdBkKMuGsYghzDxA9ES?=
 =?us-ascii?Q?qYG3573omi4hlI2ifUinlLUpNi8ydH9oMvWbPM8cWoXIdXYlJsT+y8WWoj+6?=
 =?us-ascii?Q?4sqKBnwWCGpyBizgFd/KmqE0qlTgsNbucbp5dtWjk5O+P7E7g6k9hrrjGBdm?=
 =?us-ascii?Q?ZFA4s57IsRYfbQKxxEwMrLj6Kh5hCdj+C75uwCMHHKY5KvAJI2pf6yXMSmEq?=
 =?us-ascii?Q?npHSg1ipB6O1PHf5BSEtVbi04QaIORkJH3rEZhZI8F+SwD79bpxZe7WxvQuO?=
 =?us-ascii?Q?nynUGQKu3jZcXqe8YJwtpvGsSeUFTHiX7Mk+AxYlYMc+Ruw2BFBLn0QFoDel?=
 =?us-ascii?Q?nS0yVSrT3QvCOgR1Xb3LUsr4iB0t3nZgicPprWaoAO/Te/+BMskupCfXJ/W8?=
 =?us-ascii?Q?aAi/KteVjw89vxRH76in2NHut37BFgHS2V/a7KXcou0QuYlCmmo5l+vOghag?=
 =?us-ascii?Q?kDa9gp+U5hoIgvRYJ/+l9Whoz8V7KaIAMBMHN/C9+I7of05qoecqkoDkFkd4?=
 =?us-ascii?Q?bkQK27e4d+waJ2xnKAMoT61GyCl+KtJm49zb6r+FXOWNGri3RVnE+6rN+eGp?=
 =?us-ascii?Q?M+itSaP9gu3J82X9Gbcskt7I49aolaRETA7cZzGNdIfcooftd09KjzLyPZJq?=
 =?us-ascii?Q?PTfHjNtSiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9801e4e-36ef-48c4-6162-08df397bac27
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:25:44.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vZvJhQi5m5LzWKDX3cIf3EEebY29jFLeZlYqtmxbe4YABQr45QpBLQMAy3BDQXsfgh0FYNyX2wLkHkkihQ9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949

On Fri, Oct 30, 2026 at 01:28:14PM +0800, Bowman, Terry wrote:
> On 10/30/2026 4:59 AM, Richard Cheng wrote:
> > CXL protocol errors are reported through PCIe AER internal errors.
> > Unmasking the endpoint's CXL RAS register alone leaves the AER internal
> > errors masked, thus the notification can't reach the Root Port.
> > 
> > Unmask AER internal errors during native endpoint RAS setup for VH
> > devices. Allow cxl_port to use pci_aer_unmask_internal_errors() through
> > its module-restricted export.
> > 
> > Verified with QEMU mem-data-ecc injection: the Root Port AER interrupt
> > fires, the CXL correctable-error trace is emitted, and the endpoint's
> > CorrIntErr counter increments.
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/port.c     | 7 +++++++
> >  drivers/pci/pcie/aer.c | 3 ++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index c48216e5078f..c94a310061b0 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -121,6 +121,13 @@ static int cxl_ras_unmask(struct cxl_port *port)
> >  			orig_val, val);
> >  	}
> >  
> > +	/*
> > +	 * RCH errors are reported by the RCEC. VH endpoints report CXL
> > +	 * protocol errors as PCIe AER internal errors.
> > +	 */
> > +	if (!is_cxl_restricted(pdev))
> > +		pci_aer_unmask_internal_errors(pdev);
> > +
> >  	return 0;
> >  }
> >  
> 
> Hi Richard,
> 
> The unmasking needs to cover the RCD case as well. The RCD AER is used to mask reporting. 
> The is_cxl_restricted() gate should be removed so the pci_aer_unmask_internal_errors() 
> is called for both the VH and RCD cases.
> 
> I confirmed Sashiko's finding that the unmasking will never execute, thanks to this early
> return:
>         if (!dev_is_pci(port->uport_dev))    <<== Fails here
>                 return 0;
>         pdev = to_pci_dev(port->uport_dev);
> 
> For an endpoint port, port->uport_dev is the cxl_memdev, not a PCI device. So dev_is_pci() 
> is false and we return early. The PCI device is `port->uport_dev->parent`.
>

Hi Terry,

Thanks for the headup, and I've also send a patch to fix this issue [1].

And seems like your patch mentioned by Li Ming is already covering
this bug ? if that's the case we can focus on yours, if not I would love
to make the fix in.

Best regards,
Richard Cheng.

[1]: https://lore.kernel.org/linux-cxl/20261103063409.18275-1-icheng@nvidia.com/
 
> Note, I used base v7.3-rc7. I couldn't find f0c48323b040.
> 
> - Terry
> 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index db4f607f889c..94eca22422b7 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1287,7 +1287,8 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >   * Internal errors are too device-specific to enable generally, however for CXL
> >   * their behavior is standardized for conveying CXL protocol errors.
> >   */
> > -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> > +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors,
> > +			  "cxl_core,cxl_port");
> >  
> >  #ifdef CONFIG_CXL_RAS
> >  bool is_aer_internal_error(struct aer_err_info *info)
> > 
> > base-commit: f0c48323b0402349530abc60ea908b5f5f40c395
> 
