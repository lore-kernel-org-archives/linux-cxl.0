Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB41C4708E
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjACVHp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjACVHa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 16:07:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B6F15728
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672780048; x=1704316048;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R0eX86LwL5NIS6MoSbWPtqBRB2p28sV1L2KOGAq6ws0=;
  b=m4rO8TG/rEVfkY3vudaxG2U8eKiBoELUAmYfrHCGCPGuHIG+sU5y7yKr
   RjALVHT7qRFtrsjaT1hjLIIvYIRDOhoJDoGSygLfxpUph11AE2h7SZWcu
   qfSy+L0j6+VorYUZ3ABfFyu0PZDGlfZPCs5yRnbRBsYA/+4/DmZnV8V4T
   UtDN9CMj3Y9WPGhHel+j9/17Tk1fd3E4+9YQZAbHBn5vOZXCAjLfqJEla
   5EkSehLJ8zjP0Ii+M5HdMtc1tufBoMiSPZIgWQ4bDYtn1XsLg+i/ZC9eM
   C7BiqxZetkEPdgX9UjQusnt2d7jb0E1zP7Rrt05/L5YWNt7k9tbisnPEx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="301443511"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="301443511"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="723408557"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="723408557"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2023 13:07:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 13:07:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 13:07:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 13:07:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4Ns4jvuBHVWkVAGTprijR3UlIipCn3rkOZPhqrx5Q+sl5d4bC+9tjjfJ6teJqAPplCZ8j6nwt+oiDXs1HAvE/pldYCmbd7REDqe72fg98QVY8dJ8vTOm3n8X11ImyRgDBShycyNgqUDS2+7v9D2PYwWP4g4iU/6suuUJy56PxtGGwBudXLFxWKM5Mt9RGATn2dooN/uS5SsPY3I3IbolWeJkyLPxJLqttGa+xPVlx1SsM0QDE1H2vHTSxxwqoVf+rN44Xe/ySBV2Gh+4lSPOoABAlNy1N5oIOMnl5s+jZs3Ik0I2gUCueZOrv7bVlH6NhdjPx0KdZW8wg3r/yDUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maMElD/9Vq6r8C9FsDrQaKcDkkZm9/pKDTH86Tli+uU=;
 b=iDA0bdApjpsdAI0EhOMtPgYOaJBSSCu7JMhggsy8rRG8i4ZNI2rMkk8OdQgFpSNyByYDPP1J9AO5QeKUSOwu3L5jC6UAWh7nmUOA+LxOz7uCv+TfBtnaaCiTtZBSCQ2hn4LJOFGREJo9nuSlJAsA5IzvCCDOXGolBu7neclDoIdXgM72OQl98/VWjnPiVd10A1O0mqBJiAxsvcYoIuyYkUjVanA6eeQVHHI36GJOs6cHrTOJy3je5C4yKh4gWpYZlK1/ezWgg4ZJnW2RsTnJ7gB15tSs6gXqSp6DmV+ZI/yjSe/hBH6iXiV6sFFnS6BE4M/kVXRec8cvoAWfFjccww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5296.namprd11.prod.outlook.com
 (2603:10b6:5:393::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 21:07:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 21:07:20 +0000
Date:   Tue, 3 Jan 2023 13:07:18 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rric@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mem: Quiet port walking warning
Message-ID: <63b49906246a_5174129457@dwillia2-xfh.jf.intel.com.notmuch>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
 <Y7QIP33kUAEPp6sb@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7QIP33kUAEPp6sb@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 0060e6fd-6240-4210-1bbb-08daedce80aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwqkPscvWgvx9PHvRQH94Nziqtsq+/SLWUYWQQDGlOTdu9vzPuPTk+hKvNheUUaTFNvRjqZajRIlqdoYYTsOGbTQ26aC4bYCsN+CjEFsbO7mdFVX+cV/VvhpBcJbT1xK9Cgr+ThRW6BhdFg0LtXnWn9y0icnHR3OBSG9mgdd5jZQ6nW9kL+O6IGwj/JlCDrZku5CVeb3WlVixkxPlUgP45KsdHSoE4QKSFojEin+gteREk2HNPer/0CdtV1FL23ims+aUTKf9mYalWFnQfBucrCBz0i8f9GVkIVhrZ7vAfyV2nhO4zd91iIH1h3mwwDo3jszvzCc/dofXxfVl/1aeRCZm6+Bk6uHAxyZifvaAEMV5w1QOgYcdfiJgNkK0chep2BPamm2BrcP7in5UqdlWv9b1NapcjJ/IOzzwmvNMXVpfq218zO5lHr66+ZbVHfAKyvmYB3WzNfkWSzFOkC20sEezXX7E+RE/V/E02AbB31vw4YY+J7uKVLqVOprfO5kr9FroyefNMHlEZFqH9PwF33imQWRA3gA9h09EBAS/O3d107YRSKzNCshWQMIPZSEzQaFrIODZ8engKnr4KnmGiwqdXUcvsGJspHHdk/g5mE+xzPv/708U3JTv1SwV6e+Km41cHHkakoWkU6J0BPYZYljCn3IvB6IZ8mQn/mp/nWXqBQhCaHOMT3wtCZEqobLrxM/Mty/AjxU8A8FlCheSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(83380400001)(86362001)(82960400001)(38100700002)(2906002)(110136005)(41300700001)(5660300002)(66946007)(66476007)(66556008)(8676002)(8936002)(316002)(4326008)(186003)(53546011)(26005)(478600001)(6512007)(9686003)(6486002)(6506007)(22166006)(3714002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxdoAPy30ksuwXodQA30Vw4A7b+CoKHckLBjj2cOHbE3Fy16k8FrzG7ciQYM?=
 =?us-ascii?Q?geszzglgKMsAavGN4tw0GyRPidZPtypx+CFo/0pT+qVXJXVFA3j9SpvJMz4x?=
 =?us-ascii?Q?sQMgr4TKkWYSAYXe0smOkSGHuR0/tcgQ3n1VeumiYK7vZLJt0buvXlnlFOav?=
 =?us-ascii?Q?1YCsWlIZyYJSaKgLfQtLyrGMoTMBAELb5qn7oxrZh3gAnImPLgcuSGflBr77?=
 =?us-ascii?Q?RVMhZEDBPurwX4P2R9QlSZhDVDo6YlHsb1q9QVU0H35uzegw2c/9pC4Aemh2?=
 =?us-ascii?Q?8QlQ7McnZ9Gk4u5PEX1hrUXV8byrp6Gcq1RjjcXP2Ci45m1hbkqUxH4hst+8?=
 =?us-ascii?Q?RFgPIrT8U40Le0+rFACyPIzDyINZwsIGhNl5A6SQCYg5Y9bnGfuaOtCfDDa4?=
 =?us-ascii?Q?2U9AvuUxt9RfSu/DWMiAkPzzyvqLBj1l/9TB5QRo9aJdMywATRZ1mpNV/HIe?=
 =?us-ascii?Q?9T4jsBbgR/Kqy218qTLNCwsfpr6Ee5yTTAJh7HHWEnmMX+9DP7f0RBIhXvLP?=
 =?us-ascii?Q?S4qCaQSGNXAkuskEbTWm4i5wCb+HBT5WnQQtHifHMianJ/NeQM15gnkYV+ym?=
 =?us-ascii?Q?wxBDvbwoacbu4yaKKHep4Z6pJXjNcaan4VpDCDhh4IIoR0Kh8cazdw5cNp/g?=
 =?us-ascii?Q?23BN0aXF3SoP6h3cxHVUYjcwXDJQrta3hxs0AOTS35Habrim9mhfxtkdtv9E?=
 =?us-ascii?Q?qs/6f56eIHlWfN27fkI1qVttuEauv5fJumQ7ceaZMp2cBx/L/oPKOR+RCUcx?=
 =?us-ascii?Q?mud0NMRnm1/Ca6CNwwKCGL7eLpCTX4nufFgm52YbYBW1VYW+WJueuRh1IWa1?=
 =?us-ascii?Q?PKVnBVOFHMieuFo69XYLxTj1LQFHQ7Tjjcu4S2Ev2aHsbuDkokU91utjEa07?=
 =?us-ascii?Q?IUyuNtSZfoLCis6/yBisOSvukeqv/7rSsngrty0dUH4lgyU8FuOcpKD73/4E?=
 =?us-ascii?Q?XRGnYZTaiFUOhANdzi/4PQbds6+9grDWtaC1DuleoBLBhwaxOCvC5VoBXUGI?=
 =?us-ascii?Q?ifMhiXCt45bR6IW2fZnKRrTPu+Y4RtBEbIpqoQ3dhkSxkSsxeS2uBR2LPT6i?=
 =?us-ascii?Q?vK5GRhLpt2mABCqR1x6RzOybChh8OdEcHHxi/22/RJG49H7TvjBjt3hN6lcZ?=
 =?us-ascii?Q?ZsQdAGb9m3vnOdOGKoOGnvR3ZYBnqCNbKMhok8qMfxES7x7U0eW31AkYm+Lm?=
 =?us-ascii?Q?EWz+bF1TzcDJ6nLe5XqEwEqoemzAE8/Licub2eyXEuZCOnF1VninC5ZLByT/?=
 =?us-ascii?Q?uJMpvuDuJWkggKSkWOM/vGagIQJWvml1z1euxXL56c2LJQUh7f3x/KUr0gvK?=
 =?us-ascii?Q?dSBPWZeZnoPvnn5IeEixAJPNcYBIBzEdafDuxItBu51OSz05srsCkpCnhukE?=
 =?us-ascii?Q?WK14+78fEu0V5tzXo6Zycg2xBcDydCpzSUC9y5VgHJYgIo7GuFkTeyAGXQ64?=
 =?us-ascii?Q?XDFvjts2GdjIbmbT0ti++lc4WagZy9Rz971wqP+fHj3F7xzdoFQXZ4zX/bLQ?=
 =?us-ascii?Q?e9plkuK2EZyELFPsxJWnUnCFgZePbaDA/Ua/9j9IQ3iuTotd+swK+AgY8dRB?=
 =?us-ascii?Q?CLc43eGGheLh/7QwRnenQGzh/dIogEf5qkdQDvk1guaxrmULMAZpWb2EBz8g?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0060e6fd-6240-4210-1bbb-08daedce80aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 21:07:20.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1eWhqjpgEGkwW1cfcyn/ynmLNprnnnJ3zG9fWE6PmTUH2p2QvMzY4rGRtxnLjCUy6qrhLJrE6eebqi06geX0PqI86IIsFyG1x9j+OxJEyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Robert Richter wrote:
> On 16.12.22 17:33:32, Dan Williams wrote:
> > The cxl_mem driver attempts to establish, or revalidate, the cxl_port
> > hierarcy to attach a cxl_memdev to a CXL platform topology. There is a
> > natural race (on ACPI platforms) between when the cxl_mem driver
> > attempts to attach and when the cxl_acpi driver establishes the root of
> > the topology.
> > 
> > If cxl_mem_probe() runs first it will iterate to the top of the device
> > topology without finding the CXL platform root. That situation is benign
> > / expected, so stop warning about it. The cxl_acpi driver will poke
> > cxl_mem_probe() to try again once the CXL platform root is established.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/port.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 810e60cc331c..6296d2bc909a 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1400,8 +1400,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  
> >  		uport_dev = dport_dev->parent;
> >  		if (!uport_dev) {
> > -			dev_warn(dev, "at %s no parent for dport: %s\n",
> > -				 dev_name(iter), dev_name(dport_dev));
> > +			dev_dbg(dev, "at %s no parent for dport: %s\n",
> > +				dev_name(iter), dev_name(dport_dev));
> >  			return -ENXIO;
> 
> Maybe we should also change the return code to the common -EAGAIN for
> this case here too? It looks like it is just passed to
> cxl_mem_probe(), so there are probably no side effects of this change.
> The probe is triggered then again by the base driver.

Good point, might as well explicitly return EPROBE_DEFER rather than let
the driver core turn EAGAIN into EPROBE_DEFER. Tests seem to pass with
that change as well.
