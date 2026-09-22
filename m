Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15B448BB8
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068544; cv=fail; b=SvbMLVPNcTNKu1LZRfkCG8kFQJwEUIgdUDiDsgCPyBeQ+Qvxt6cyzayktbjxhNlWqlhHOLMof9Qk6DmPO076a8hpmWb5p2Aza8GgZda1WOYScrIg13Ung7U0zSfC8I7isYAypOrPHLfJ0jIshITdwiCTh+/1Mm7fUQ2iL+GObks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068544; c=relaxed/simple;
	bh=acukKuf5JTmbMS3/SrUb1JSA50wm7Cvm9PF9qPXi2ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uD32PCjtBPeQl076JCrXcmNsgL1TZo+PW6oYkxnYSfEJzYtT1qIHmtwLYoacd1Mhn49/QmEM//cnsmrnuJSiA62v89AlmoPDwYZSIPA4331yir+tNrTPiwkMV+BiCMUX/19JOPlkpY9R0aCK6ESUjFIZXnxKBjo3MMRD1tgiwuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHs3Dsre; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHs3Dsre"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSzmvzU46FzSzFSOdZELaGaY+gNMUz+WNvjYELLcKI6RplOSGmtZMy1ywOvWOWChHotov05j6GkpFjBrNmbp5PZiwH8X66/Qxjjd2SQ7y5e7onj+D7YFi5a5ZuwOgbb7h2MEGuHT2pI61730tnzbc4pDl9dIhXqrJu1uZK4uSy+80YhYNGL7iqY9P/pb1dKjLcHWbiCjfAGDyQoIqqLedLR8+qyI1nrztt+pCBPfFP8V/vdMZC2d5lWu2tislTgtXeKRwvD28o0jYmKpYIekJpxaTOI197Hy2LRtxkp059qXYwyJTwbS+BNFKlZAO29Zhoa78EOiRDKkxnN15ePRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezIxfdxYmeoDaPT4gQBcUmHlmpPOMWNE6eYxAOc5FHg=;
 b=cxRPqsLpjEkwKk2mHGlH12hd0xQrfFqeYaiG54YL1S9T8S+Pd2kwP+B3XPtMNv5QFqCCEUZXkNjSQJxujZS/6/ev6ZwWnHlHjT5tPzU6/liXBfdj7P89N35pa6flnJE3N0O76Oc1Hq8bByGN9odE/RdfFhm1oUzOvmY366VfOdikHNyBKFu6mOQg/R/9EsM0Ct3fKdtvjLQuvEyqclIPQ06NazV1HTlesr65hbcIGgjCafTeXCl/bwLdGnMAAZUlrA8ntsQ5yZ2oasCBKscBZCU3uAcYHaGuglEEbwQ/sZCt6Om4qCAHggHYnVUqfnW+NRox0eROQLOrfeogHYONRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezIxfdxYmeoDaPT4gQBcUmHlmpPOMWNE6eYxAOc5FHg=;
 b=HHs3Dsre6Jw7zohc5hxo4KB3IQfq9KLiQ9ldB6Eu0Cb09WZYbkwjW1ufZbP9osjcS66TnPQmJKFK+Daxx1RXHOvC1HhS51Dd5OnPMN2TA3VCJEY3fGWepNlhdrgxgw52bZkLLAHkyIVZcjPY3r300o6O1DS008nDxr0Z698dYph3dU9pXY+z7RPQvDj3oWM8MkkQWamQJELC6Udlz0YhUJ8yL0iPfcmu9BVd3IxO/GKpfGPhD7VWzsnnqLd+IZhaJMGWedr/MqX+yeuJ1vE7+vHtgylqGWaY++1BOHuRa88Z0gkmPRmgUgylIJbKqbhhCVUQE3V9CJBDdrXyTV2Cmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:15:38 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 09:15:38 +0000
Date: Tue, 22 Sep 2026 17:15:31 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, 
	Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <arJG8DlfoCyTdLRr@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
 <arIWUWkmkwgLzQqh@MWDK4CY14F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIWUWkmkwgLzQqh@MWDK4CY14F>
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 556885a5-47e5-4081-e532-08df188a10f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dFf3LYufR1TuGXg3tu5/vQi5ky5rHoYxjLmaNUulkMOzjA9Dn7K2X8+S75V3/tslIjWA+dhegoFyEag0aYwhunry/8nFbQh/iq90mIfSH1s5s6brsfjwxv/FQsB2KyZVKvCPnycQbhNON87qmbzSsBdv+cBxtVbeGdzzGCJsBrME9xoP+xElDGtFUEco2dc8iLlXu84DIw/VlBJa6f0KoRCRnwW7vJE6Z5cCnodQ1ZW2kroGDO0pf8vP97wtg9+igKuMIAJKJQmgFwbwBJV4leNUHacMQp2V0nmDxLMH68gsXbPjhyeGGtiIfE+81wVZiisaVq1ykr8DN3gPlfHKd/3r+5aQq/aMndSd0rBSiX5eG9W06Ih+L9QSy+5wBR+xBc3h6fI/4ThJovWNxTaJPJ/38Czgny0miBf9VKQLqNNQrLqwQvm5dmt65yP0Jr6HWCi9MhpHBIwiaUQQ154L7jj4RL9p0ZG1MKJeOzXa9LEmlLb6YP34pCHIvrQGyS6nSfgxc40cddV0dzIwyn8uajOPiIf4QfN9TzOErMSbP1OjjuupKVfOmiRsiYVAjCnmIrQNwMMKq5IRmjosLcjj1OEWCIMlYqXltUQTP8GoD9pHi7QkmAL+plHBCmrRGwYarUBdfbvzOj+IgDua75ovhMeFOZmAS953YqMrrWBBzEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nAYBic4fSSmGApkfBKJy4i87wB2soATe3o8CTIthgwEp1f47B1Ss/NWKA0Fm?=
 =?us-ascii?Q?MB7jS9/KxQMsaxjPgrGzswIKgpXFBg/WbclqUKgAkwXccgw35wVdCR6rKeRs?=
 =?us-ascii?Q?PkeL0j1/W4+THpoj5xSg07iS/EYKG+/5+jc/rLJUKsp0vfMijVrTyneSbCyg?=
 =?us-ascii?Q?FUB9hJquyL7Ot+xNdS7HvEDPwCIDH+1xEic2Nxs0ppywNIO5hUjVgTOIXPQP?=
 =?us-ascii?Q?dzD4tzH32xmlLlf6sGRHLAD12Ng/uHWHMqiGDBsLfn9Ww2YfrfSfOn5aMCg9?=
 =?us-ascii?Q?/uL9SLVjC35ZIHaPTcR0bEBeAag7kMzrgg5nji0zmtOMuPpBFB7LH1RgvFbK?=
 =?us-ascii?Q?ECjMyAZOG7taIgflZz9nFU/BNdbJLoInGchHzt03QVzaCNFRZCGDJ/jjWAMW?=
 =?us-ascii?Q?3CReaKYWsI/RauBL0/Vk62ooFiAZhz+1MdzKFqAbIAndJfJQgKaJSPbe1t8l?=
 =?us-ascii?Q?PMsz03SUIxenUh7zOwGC+G9WizETk9Oxj7Nz8AvhDGU4FL+e0bIuSTSkFWp8?=
 =?us-ascii?Q?grqO5/tQWgYHasw9TYllc3UiFkEMcOmr7Qb8NvO5fpCmGDT1A2BBLehDVO0E?=
 =?us-ascii?Q?vZRaeCVY5Dd+iNDiBE7/qdfwPb0CMHUO0VaDY08+p3M97pf6TxOVTaD8i6eL?=
 =?us-ascii?Q?Mn2AOcyM3YXnVh1tyKYnoT4Xuzg2wYO9LT+B3DTEa3J4S4j9RPDtI9utZCnM?=
 =?us-ascii?Q?UBNm/AMahLvVeOp8vJGGHwFWXDj3VQAETDha3qSSNC5YPwJvI869DzJrECbh?=
 =?us-ascii?Q?UkLXfitBaUq1+YueOlb8lDoRUxRaDJdxAK+GkDfTf16NrGk9Eo7DZRVCukLH?=
 =?us-ascii?Q?/HWGsKuzVL7VNJYrNEpEc+qtiUknIJlFmXesIiKN9zLHLMZSw+/oQE+9Wg0N?=
 =?us-ascii?Q?mPNky2ZpdwJkLkTpodGA4p+YD/ziHhER+d5fAXVbertRDk5j0su/pprAMJQJ?=
 =?us-ascii?Q?UoVX3jAXkK0DyWJwLW2hQzk8XmcKF7rUHbla1NY+nTrUX3LgNV7000K6iXWN?=
 =?us-ascii?Q?3b4jQ8cFgmr1RCcXIFExw58RWGEPt2xnRgCeKt89hRPslq74PrUKB43FWPC8?=
 =?us-ascii?Q?5bpnajdGnxyKsKbhkqdkd2+6ZYP4K/RBdxyDNSrfPHvXY5/gyuKe+8nS6Tp0?=
 =?us-ascii?Q?W600bT8e5ZCRJyY4qXVGQ/8fGpp9Xakkv89lmAxaAALfAq3nPneNTFLiwV6Z?=
 =?us-ascii?Q?l8d392tud711DAVFgcotsDLp7j8EEJ4uE0znm9JJGybfaRUD51mRItxevuXH?=
 =?us-ascii?Q?imSwKh1Ax732RGLefVGKZ+DzLG1MjnjVp33kvo1vwS8iSjs1D/O/90I+GIw5?=
 =?us-ascii?Q?CQjPUdngiy+BTdgOQcpDT+BFUF99oO0H2Js3VnwIeWRIBVr9Gn0hs4GFZuYz?=
 =?us-ascii?Q?kjZycANRSQfUVODVPm5MACOiVmkW5Mhm9QL3tEPUMyX2rjy0LPL71lGIzy8M?=
 =?us-ascii?Q?IAFnH+ZUXv7zbH7dzK2sWKzAUXen6roSn0ggH/bQu5PSWrgA9/9XyMxaztz/?=
 =?us-ascii?Q?8ta45rSAuu/5PqF0Kps8jPcOZDqJb7neWKhFUtbnzX3DWMvq3+Q52Cm0NdBB?=
 =?us-ascii?Q?sPkcrtrI/aDN/cOp0G/cgkMOxl72O1yS9TpkhgUwXLAiQ9IzHdkmBZ5aSbd7?=
 =?us-ascii?Q?cFa9IIYJuSbkJw4badmZYsIjn9J174jhES0BGzDEb8ch1wQADLkpneW3jlRv?=
 =?us-ascii?Q?FxJhXpPg/d17MpjRdn0Nwfz1KnBBoCaW3crr5Igq53zqgLSEg9sJ/9e81XZs?=
 =?us-ascii?Q?6Si4jmhuyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556885a5-47e5-4081-e532-08df188a10f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:15:38.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5bC2n7ba7GhujMrby6XxVuWKOncDBjtzRa8zwDiL5XXSlhw2YDMOZq+WXjQdgtxrpjzCeD3bgAiw00jME1EDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783

On Tue, Sep 22, 2026 at 01:48:38PM +0800, Richard Cheng wrote:
> On Fri, Sep 18, 2026 at 01:30:15PM +0800, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Dynamic Capacity Devices (DCD) support extent change notifications
> > through the event log mechanism. The interrupt mailbox commands were
> > extended in CXL 3.1 to support these notifications. Firmware can't
> > configure DCD events to be FW controlled but can retain control of
> > memory events.
> > 
> > Configure DCD event log interrupts on devices supporting dynamic
> > capacity. Disable DCD if interrupts are not supported.
> > 
> > The DCD event log is not drained here. cxl_event_drain_mask() reports
> > only the logs the driver can service, and the DCD bit is added by
> > the patch introducing DCD event handling. Until then a DCD interrupt
> > wakes the event thread, which finds no log it owns and returns.
> > 
> > Care is taken to preserve the interrupt policy set by the FW if FW first
> > has been selected by the BIOS.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> 
> Just a nit below.
> 
> > ---
> > Changes:
> > 
> > 1. [jonathan]: get rid of CXL_EVENT_STATUS_ALL and instead opt into
> >    event logs we want to read individually in cxl_event_drain_mask. This
> >    makes which logs the driver drains explicit if new logs are added in
> >    the future. The cxl_test mock names the same four logs for its
> >    probe-time drain.
> > 2. pci.c: when BIOS owns the memory event logs and a short interrupt
> >    policy has just disabled DCD, return before Set Event Interrupt
> >    Policy and the event buffer allocation. Nothing is left to configure,
> >    and the Set would only have echoed firmware's own settings back.
> > ---
> >  drivers/cxl/cxl.h            |   6 +-
> >  drivers/cxl/cxlmem.h         |   2 +
> >  drivers/cxl/pci.c            | 127 +++++++++++++++++++++++++++++------
> >  tools/testing/cxl/test/mem.c |   5 +-
> >  4 files changed, 114 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index cab8ce39f465..1add114bc178 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -192,11 +192,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> >  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> >  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> > -
> > -#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> > -				 CXLDEV_EVENT_STATUS_WARN |	\
> > -				 CXLDEV_EVENT_STATUS_FAIL |	\
> > -				 CXLDEV_EVENT_STATUS_FATAL)
> > +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
> >  
> 
> Can we retain a named mask of the 4 standard memory-event logs?
> Instead of repeating the 4-bit expression over the code base, why not
> reuse it ?
> 
> Best regards,
> Richard Cheng.
> 
>

I just saw Dave and Jonathan's reply, agree with them.
No need to reply to this one, thanks.

Best regards,
Richard Cheng.
 
> >  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
> >  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 9fd5af2e41d4..9106affd7c81 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -240,7 +240,9 @@ struct cxl_event_interrupt_policy {
> >  	u8 warn_settings;
> >  	u8 failure_settings;
> >  	u8 fatal_settings;
> > +	u8 dcd_settings;
> >  } __packed;
> > +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
> >  
> >  /**
> >   * struct cxl_event_state - Event log driver state
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 7b754af2168d..fee3a704b73b 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
> >  	return true;
> >  }
> >  
> > +/* Event logs the driver drains: standard logs when native_cxl */
> > +static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
> > +{
> > +	if (host_bridge->native_cxl_error)
> > +		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_WARN |
> > +		       CXLDEV_EVENT_STATUS_FAIL | CXLDEV_EVENT_STATUS_FATAL;
> > +	return 0;
> > +}
> > +
> >  static irqreturn_t cxl_event_thread(int irq, void *id)
> >  {
> >  	struct cxl_dev_id *dev_id = id;
> >  	struct cxl_dev_state *cxlds = dev_id->cxlds;
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > +	struct pci_host_bridge *host_bridge =
> > +		pci_find_host_bridge(to_pci_dev(cxlds->dev)->bus);
> > +	u32 mask = cxl_event_drain_mask(host_bridge);
> >  	u32 status;
> >  
> >  	do {
> > @@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> >  		 * ignore the reserved upper 32 bits
> >  		 */
> >  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > -		/* Ignore logs unknown to the driver */
> > -		status &= CXLDEV_EVENT_STATUS_ALL;
> > +		/* Ignore logs unknown to the driver or owned by BIOS */
> > +		status &= mask;
> >  		if (!status)
> >  			break;
> >  		cxl_mem_get_event_records(mds, status);
> > @@ -551,42 +563,62 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> >  }
> >  
> >  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> > -				    struct cxl_event_interrupt_policy *policy)
> > +				    struct cxl_event_interrupt_policy *policy,
> > +				    size_t *policy_size)
> >  {
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_mbox_cmd mbox_cmd = {
> >  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> >  		.payload_out = policy,
> >  		.size_out = sizeof(*policy),
> > +		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
> > +		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
> >  	};
> >  	int rc;
> >  
> >  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > -	if (rc < 0)
> > +	if (rc < 0) {
> >  		dev_err(mds->cxlds.dev,
> >  			"Failed to get event interrupt policy : %d", rc);
> > +		return rc;
> > +	}
> >  
> > +	if (policy_size)
> > +		*policy_size = mbox_cmd.size_out;
> >  	return rc;
> >  }
> >  
> >  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> > -				    struct cxl_event_interrupt_policy *policy)
> > +				    struct cxl_event_interrupt_policy *policy,
> > +				    bool native_cxl, size_t policy_size)
> >  {
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_mbox_cmd mbox_cmd;
> >  	int rc;
> >  
> > -	*policy = (struct cxl_event_interrupt_policy) {
> > -		.info_settings = CXL_INT_MSI_MSIX,
> > -		.warn_settings = CXL_INT_MSI_MSIX,
> > -		.failure_settings = CXL_INT_MSI_MSIX,
> > -		.fatal_settings = CXL_INT_MSI_MSIX,
> > -	};
> > +	/* memory event policy is left if FW has control */
> > +	if (native_cxl) {
> > +		*policy = (struct cxl_event_interrupt_policy) {
> > +			.info_settings = CXL_INT_MSI_MSIX,
> > +			.warn_settings = CXL_INT_MSI_MSIX,
> > +			.failure_settings = CXL_INT_MSI_MSIX,
> > +			.fatal_settings = CXL_INT_MSI_MSIX,
> > +			.dcd_settings = 0,
> > +		};
> > +	}
> > +
> > +	/*
> > +	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
> > +	 * support, so size the request by the device's policy_size and only
> > +	 * enable the DCD interrupt when DCD commands are supported.
> > +	 */
> > +	if (cxl_dcd_supported(mds))
> > +		policy->dcd_settings = CXL_INT_MSI_MSIX;
> >  
> >  	mbox_cmd = (struct cxl_mbox_cmd) {
> >  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
> >  		.payload_in = policy,
> > -		.size_in = sizeof(*policy),
> > +		.size_in = policy_size,
> >  	};
> >  
> >  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > @@ -597,7 +629,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> >  	}
> >  
> >  	/* Retrieve final interrupt settings */
> > -	return cxl_event_get_int_policy(mds, policy);
> > +	return cxl_event_get_int_policy(mds, policy, NULL);
> >  }
> >  
> >  static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> > @@ -633,6 +665,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> >  	return 0;
> >  }
> >  
> > +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> > +			struct cxl_event_interrupt_policy *policy,
> > +			bool native_cxl)
> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	int rc;
> > +
> > +	if (native_cxl) {
> > +		rc = cxl_event_irqsetup(mds, policy);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	if (cxl_dcd_supported(mds)) {
> > +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> > +			cxl_disable_dcd(mds);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static bool cxl_event_int_is_fw(u8 setting)
> >  {
> >  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> > @@ -651,32 +707,57 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
> >  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  			    struct cxl_memdev_state *mds, bool irq_avail)
> >  {
> > -	struct cxl_event_interrupt_policy policy;
> > +	struct cxl_event_interrupt_policy policy = { 0 };
> > +	bool native_cxl = host_bridge->native_cxl_error;
> > +	size_t policy_size;
> > +	u32 mask;
> >  	int rc;
> >  
> >  	/*
> >  	 * When BIOS maintains CXL error reporting control, it will process
> >  	 * event records.  Only one agent can do so.
> > +	 *
> > +	 * If BIOS has control of events and DCD is not supported skip event
> > +	 * configuration.
> >  	 */
> > -	if (!host_bridge->native_cxl_error)
> > +	if (!native_cxl && !cxl_dcd_supported(mds))
> >  		return 0;
> >  
> >  	if (!irq_avail) {
> >  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> > +		if (cxl_dcd_supported(mds)) {
> > +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> > +			cxl_disable_dcd(mds);
> > +		}
> >  		return 0;
> >  	}
> >  
> > -	rc = cxl_event_get_int_policy(mds, &policy);
> > +	rc = cxl_event_get_int_policy(mds, &policy, &policy_size);
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (cxl_event_fw_owns_mem_logs(&policy)) {
> > +	/*
> > +	 * dcd_settings cannot be sent to a device whose policy is too short
> > +	 * to hold it, so the device would never accept the setting
> > +	 * cxl_irqsetup() arms the DCD interrupt with.
> > +	 */
> > +	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
> > +		dev_warn(mds->cxlds.dev,
> > +			 "DCD supported but interrupt policy is only %zu bytes\n",
> > +			 policy_size);
> > +		cxl_disable_dcd(mds);
> > +		/* DCD was the only reason to be here */
> > +		if (!native_cxl)
> > +			return 0;
> > +	}
> > +
> > +	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
> >  		dev_err(mds->cxlds.dev,
> >  			"FW still in control of Event Logs despite _OSC settings\n");
> >  		return -EBUSY;
> >  	}
> >  
> > -	rc = cxl_event_config_msgnums(mds, &policy);
> > +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -684,11 +765,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_event_irqsetup(mds, &policy);
> > +	rc = cxl_irqsetup(mds, &policy, native_cxl);
> >  	if (rc)
> >  		return rc;
> >  
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	mask = cxl_event_drain_mask(host_bridge);
> > +	if (mask)
> > +		cxl_mem_get_event_records(mds, mask);
> > +
> > +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> > +		native_cxl ? "OS" : "BIOS",
> > +		cxl_dcd_supported(mds) ? "supported" : "not supported");
> >  
> >  	return 0;
> >  }
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 7b756000a1a6..6ef47265da10 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		dev_dbg(dev, "No CXL FWCTL setup\n");
> >  
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
> > +				       CXLDEV_EVENT_STATUS_WARN |
> > +				       CXLDEV_EVENT_STATUS_FAIL |
> > +				       CXLDEV_EVENT_STATUS_FATAL);
> >  	cxl_mock_test_feat_init(mdata);
> >  
> >  	return 0;
> > -- 
> > 2.43.0
> > 
> 
