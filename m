Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9714387
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8MVI515"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A35D11B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 21:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698468689; x=1730004689;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DDdHByjbD9tjK5IrxR923Q9fn3o3xg/r6v9R0u9vj44=;
  b=T8MVI515Cb0E8I8goiGQ0/zc/UKREmkF4aSk/Qnq2+Sv/rhLXBYWxCJl
   H7V1wx8Tx9v9OjY05MzQESXGCA83ZIzZnubfmU9VvqcxEbK7d+5DpVC0m
   ohGD/8YxrQ6IAoFwwMh3rZ77NW+IzsAADQPNtDcsSgUihAEcezI3imG6M
   gS1MyXF2TkQLI4T/fJ7n49980wn5SC7lSgUtTCFfrda/+JunVr8hjBuMI
   imQILb+JNBK29TqSZGSRTCJ8y1FPmELUt5NTf7vlJtbOqF0A5kJPkkPDl
   +4uHT+cIb8kuyrqn3EPoHo/ZFwlmsJYYdm5POc5PmyoMOYnITSsEsphvn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="6512565"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="6512565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 21:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="709605108"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="709605108"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 21:51:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:51:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:51:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 21:51:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 21:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt5x1U3DS3m0UUllB3z8RJ/ZiNCXEzj5X+g83xFBHXH9kjXh7MA2qF/VKk6s/dINdRnFMSSIjC5+En1TJqxvzBsoo3/vK+vF27fyIhHI3m35IWpA3EDk4rxDgph5Iwmv5o9nmkWsdFYYqmCVtHiI7I5lHwbZh/WCXkSHA6NssPZnToJjEX8E7oKhoeysWBFoDYEImn+FsGTc2R0kU3WXX57u4vMjQB2dCoOVhibosDq2IwGzhZe9MoGR1SIksQonnSjQNCenttlMzxSoBcd0ujpV7GO7PdcOMvHeLaGsMjiLvoCsuNaxHnCyzZuqGdYMojChfevTYbk6PDBjiqADOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hFhkOcpBI6CZUS6lqwYgUcpaIq48GLKygYKJ+FNrCw=;
 b=K8BRkUOw3w0wn/57iu8uicBrE5kljcVX4IyZjRCXfUoiM3uiN0HqvPG0rCbSekC3bd0FLqmRiuJLvoWwFh+A4EUedRKYJi1nC0L1Ftx5ZNtQuvHEaDv6bVVA9egOPuYB4ScAVHmLBhpVcxQDLT0lA4K/bEapJdPgDkGbuOYu7zk9mgVwzgrn3zQz1LWX2plALpRja9kPaB/lEJoth8UlMWNmaoFDqOFbaE5BQ2jGyXQ0Izm3nnm/QPkF+/kUX63gmOkQ4u+4yKzH7iNcalfwGZ6qzR3x1PF7Ktc9ii2zZpnwn6g5FG+NWAlAFABJbO6LFVYb7wcYLgITvSopeVtzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sat, 28 Oct
 2023 04:51:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 04:51:24 +0000
Date: Fri, 27 Oct 2023 21:51:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v11 06/22] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
Message-ID: <653c934a51cad_244c8f294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <169713684660.2205276.14834262516220839119.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169713684660.2205276.14834262516220839119.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: f0703de1-4fde-4a93-f6d8-08dbd771898f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7SM2Kz7ebkWv+m+Rc3lmYIZDnUmYbEwx2NaoQsg8tdHqhV/foxPfVafAKk6JwAIbbLdDMaDQ3WMP4z8GFtFmStsU/gPzyBXuWZX5gh1UnCvkizZJ9gD9e9LGw0e3XRzAm2Tg9s5gff2sXs89cml1O+96VTCkiEGExmuQgqITbAe6WneMiZV5Z+91z32eAOwi5M879wKwJvyPezFWFPOi3/8WavfHMyQqRchVVpP8CzjQtlv4deLXcoBoJoQ2MbtNgUMqQID2PdmxAZfY2aRa9qpbRVDuZGZkDXKFbszPROclgRPyGTqbZ4W5CBZqH11+V1rpgsLF2MNy/cMA7G4My3q1c2sF36hRsQ9hJavUyXwPRQmlS/S96RVltsuCouqJam/RviGQl62d6fQcup+7wpBKd5OPiXl2xvGB2l4/wZG7cQVSW1snckvN6l1uxXLjIplrqcjF3LFR/qZ+cRE+MTY5FCy1sLtBIvPE+hpXC0QF1Qf+Xx22TCyfNQlqTm9hpH6xdiloR8C9Clg92M+3Md1LrGUz1xWvQ6GeU3d4ID6Fcz2s2G1e0NEcIxjkO1bz1A5WpzhEnu84gPARKWnkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(4326008)(6506007)(6486002)(6512007)(86362001)(966005)(5660300002)(82960400001)(8936002)(8676002)(66946007)(2906002)(38100700002)(54906003)(316002)(41300700001)(66556008)(66476007)(9686003)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83Jrv9tDK+1pj1uiSgmFFA0EH0Co+JIV9UfBVLlQ/3V5OEpBIZeuNUyUn+32?=
 =?us-ascii?Q?BKnFjv0h+jNuUs6oPcGtyGB5SmBb7aynwR16cAadtY+Dn2s0lsgD52+o9XWM?=
 =?us-ascii?Q?YvDrJK8jbPppjzQ3ykxP6bUbMJjpliH4Kn6WdGbGjqd8sv4340reRarVsWl8?=
 =?us-ascii?Q?0NLObj3mM1LdAOWk7z/BufjlO6R1v0fsnM6jY++QzX7a6u9hxk70/5lwZm7k?=
 =?us-ascii?Q?ar4VNMx/4hdBq5QI5ckAq0BF2FBQttIPoKzAs2fwIzbPiAd8Vp+18CbWpxBC?=
 =?us-ascii?Q?rmPJuW5uFghXmqh2ZdVt6FPT1A2FGFZku0DdAZDk92lMO1TVGLthnK5Buc90?=
 =?us-ascii?Q?dKqi6Tb09IzH7Mp5bDyHk2jOHZBxtQS+irJTmv41WeytYNXG3nfvHTj4NnWn?=
 =?us-ascii?Q?S80Du/4N8ZWNEzQUc2zi7GP4eISYnINPygt1ypujNEZK7xCASDlbmU8Rc8J7?=
 =?us-ascii?Q?VWtv63YjfaFasXV0iFt+u75xXgWNFpTqhutc+abvl0sSg2IGYJaRecDUAziD?=
 =?us-ascii?Q?eeEuRCqRKI9mFv/IXAj+FmDzvCyn0F1gbKdCDtqql+q9a1iYM0QgmZ5AkXYI?=
 =?us-ascii?Q?PiE4SnJOvuo9ahvnmamOwCKILOBb7S/dGaJxJggVwBbIH945opWQUdodpTMJ?=
 =?us-ascii?Q?gFvs1qYcI7Lu/L6nPYmpHD6VIDPgUh8NsUrKvqOJpBqOYCEIeGCS6USgFR7A?=
 =?us-ascii?Q?1ScA+Qiz8dxRs+tWlO3pBkahghUKdi18g50mMDWjW5kOGIMf/l3mEaA6ZJF1?=
 =?us-ascii?Q?vSXPCk1I+NPsBjHb2AxQrSWqdw4+hvBSaVaC6V/vuVJdEi+ky/chOcByKc/p?=
 =?us-ascii?Q?Rixqjf+buiD3WDQhK0AjqJWpasn2qCEdfKH08JIt5nE6FgYNTK4PKUM8rYn+?=
 =?us-ascii?Q?swhzfdmj/QXI6CDNNNJ8wALT05i4MYWBKvjQpRexJ5XQTwqgkP1cC8CRumjM?=
 =?us-ascii?Q?A9ewZMnEKzTzmq9+S7MrxXSNMoSeprjKCk7s3gFJyBGV44stKFF652yK/E6N?=
 =?us-ascii?Q?BA1feqkuCf1J9GO7f3IFaEFl/32AoSsYqxs/XReoWhN3Ph5RIi1F0FLPemED?=
 =?us-ascii?Q?LSimuNzkk2ds6WUuPklzTrEaCnLOtW2bOWXRusaNBWIMZA7RT1LYiuoO/dCi?=
 =?us-ascii?Q?ccvrWLawLXWivH19FznVTezRd0N6XzEqghlRJNYcULraxJEhijBS0C9BlffQ?=
 =?us-ascii?Q?a6rG416XhChoJ6bfNONxToeGzOMIXTacZ5jhqf5Hw/yH55Sluwf7uY9xPEgA?=
 =?us-ascii?Q?lvjoNJLUh4h6UHq4LcJwJg2qDGW5tW2WZ6/ZeOXT/DVS2cOKIyEN+XD5jGg+?=
 =?us-ascii?Q?B+V3mWub8sPkTa9RhZx6H/Qt58qVFbv3xaMNrZvyOv6Gayhzzp0tHhpgxnU/?=
 =?us-ascii?Q?IhqmIamTqLyS1InhIJnRgha/cnt/GZ9ksyvVVbhX/SMNOpdPvHm5Z9JOaaue?=
 =?us-ascii?Q?IXKKSrkWt2C9xIFvME8Hr01eLg77LF2tKNM6HFcMAaRE+E4/fs3mpzI2BnhI?=
 =?us-ascii?Q?x3F43wvx+UMNszkbcA7WS+oGVJY+r+W+Ku4n/ikH9CIu2hccqvhg8fCK087r?=
 =?us-ascii?Q?MXwL7GziSsWjIkos+LoLYUGzfOBOrje0pqsh4q5JS/oGtftwZDEF7ZlR+kPN?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0703de1-4fde-4a93-f6d8-08dbd771898f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 04:51:24.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE4ktJQ/5v/PbuFoKz7I6gk2YAmzMCkkEhU5FJ247WndjCK8ZnXeo+fJtAzruXzxdBpXeH18714pnJEGuyJX6+wo5a79LHB62NuN3rEcN5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Dan Williams suggested changing the struct 'node_hmem_attrs' to
> 'access_coordinates' [1]. The struct is a container of r/w-latency and
> r/w-bandwidth numbers. Moving forward, this container will also be used by
> CXL to store the performance characteristics of each link hop in
> the PCIE/CXL topology. So, where node_hmem_attrs is just the access
> parameters of a memory-node, access_coordinates applies more broadly
> to hardware topology characteristics. The observation is that seemed like
> an excercise in having the application identify "where" it falls on a
> spectrum of bandwidth and latency needs. For the tuple of read/write-latency
> and read/write-bandwidth, "coordinates" is not a perfect fit. Sometimes it
> is just conveying values in isolation and not a "location" relative to
> other performance points, but in the end this data is used to identify the
> performance operation point of a given memory-node. [2]
> 
> Link: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
> Link: https://lore.kernel.org/linux-cxl/645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This collides and the other drivers/acpi/numa/hmat.c collide massively
with the work pending in Andrew's tree. This will need to circle back
next cycle.
