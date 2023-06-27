Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3D0EB64D9
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0O76 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjF0O7x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 10:59:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C1FA
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687877992; x=1719413992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oGKyVDE3ZFyqz625CaD2V94Rpoyp6AuvESGn+hPtPHI=;
  b=id9obzGHu8u096m+5yl20cGtZziQQJXGPtQhQd0N34M0psHGwi/Clyzf
   8ns4FGVLD8iHUCZg9WwukkwSSbdBkcLOnNJ0FW9F3Xaz6ywxEDbcjL/Bi
   eb1Ms7WDTQyAykbuItXN1irGaDsx4Lh5snhdWigivPrDHj28XYK/rwxiI
   Cov9aWIEjrawquBm/zqGW4pmw4NmosGF2jxcZbcrI1NqDScQ50TP6Zy6m
   MbpTK9DgN/8tI7VTShx+xoA5t0aUtkSDFJZE3A9jd4y5l2k+Oa2aTCOVA
   S1nG/QvQnD3ViITUgmdPc/xdOt+BMYc9ZoILcvA7X71dLw/3WK+xbYbxr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="341931611"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="341931611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 07:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="666727605"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="666727605"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2023 07:59:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 07:59:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 07:59:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 07:59:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 07:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSd8T0DJs9rG8T7gvRjHPGNtrWW7C+uiT/2p4HXJ3Jw/gUTN+5ygnLnl3viOwxVw34fOy3ms6moudeZmu+BP1Z+JzWzU1ZEO/peq0Ym+CiCcjjSmfGtBr9aUurN7znLXJBwkqtIFqAbaCgXC4Lp9rA9KccdoG7ISO1M1siL0Pn88hrWFTx+YmZlA9LC0UtTglJDaO4Q0oVDE21sp3iQmDhUdBh8LidmDyhff0Bqi+7dH2kmlSf13ODydqbrvHzR+4VlMR7Lqwy9YAPSZwoYpoKkQSJT5p4VIqDgn1/S8NzcyyqIqV5ANXMp0YfKSz6dIEykp4dhdY6HSc+5uI9nutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDfe6Vty2NH5AGkclmguC5jNkNM78rJxE/aZyG7Jy44=;
 b=PTpqY5KG0OTV/LA2Hh+Q80gpIHZe67bE6JEQ7uOMlzK8mxDrlB8yoS9P8pWFJQMx3JxhK7okf882p+E+KweAAKXcYtlzOozdaMEZjQiryhEwWPIbdhYdbj1fKaodtH7T+yak5qGdxQn323J95+rRyhP8GsW9ax22NNcozBwjhXJmj1zh8YKNnj+QYxYBCin8MghvFqheuHuKULwyVvyVufpXVyU43Ef2q8odYMxeiwg43iKpunvZ0Y01/czkgtXM8O5J6wq7hY/vUWyl7BfOmsNFysO3cEZXUzqPAT1hl9CkmEAnY7mxFNF4c/lCwpMHHyGmxgvxQkBaaREPdYNrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 14:59:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 14:59:48 +0000
Date:   Tue, 27 Jun 2023 07:59:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <649af95cdcc62_7645b2947f@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <648b2564bf039_1c72cc294bc@iweiny-mobl.notmuch>
 <20230622160736.00005b81@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622160736.00005b81@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f49a9e-15cb-41fa-f919-08db771f266c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3F2g/hv+M7ZYNKURjxeGSVufWTGNNiG4xo/SHQl/zzUUZC7AbtH2403ra2YA90TtrXzn2RHAk0UFYRpBFvbfxEUfUcoksAFZ6+zWRvJIza9YXpH21SN8oWKCmqxm5xgBAvhan/+3egLuPGGL4hqgslNuaLX4Hn6y86JSl6VZs9cyrFVgSMPyAUp8eXlmyuqwvUQgrYlzcLnTejlL4AOX3JIDNCW+3xVEr+335sUiJQUXhOlZuOFtupagy6TCaXq/ckPlPWsH0+FAEcmPRThQzKemh7P4WnSNPr1E/vsGPanMPdPkNV/b+wNoc9ju5rpBKezxHc/nl9I9LICmHkZvERK+YHVg3tP64070/jDe8iCLusGQ5TlTCK3pCZvqyCVr42jLPPVLmD9HZNNiP5MdbcYrUFOb5uDO0dZqjg/34RlLjgneDEskmFNkSvg4iur6NXq1HvzeCkoh6+pY2K1RN1zlladYauTfnsrlxJjH/kkHpqu0rq9oVMurzfjOXc2/M0s6xJzsE+AnVWAuW6OuQWIODLRhUbxHW9bbXp42nHivFxT/CtCUzSfrXMwFV1o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(66476007)(5660300002)(2906002)(186003)(26005)(38100700002)(9686003)(6512007)(6506007)(41300700001)(44832011)(66946007)(66556008)(8936002)(8676002)(82960400001)(6666004)(6486002)(54906003)(4326008)(478600001)(110136005)(86362001)(316002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bBXq1pfGx0++BLcef/WrpcKpenvz+P/jphB/1sjfMSQKLU8MJLFiwbBCi/g5?=
 =?us-ascii?Q?5fJZATBRzUVyUrPeVFoauwbIy5XcktQ5siuxaEQlYiRJIuiuKvWIxHd68eTX?=
 =?us-ascii?Q?Va1KvgGzWEVwA3ax47cQDESuABe52In/THq8l4eCbghSiPhKGm0wqW0X3yST?=
 =?us-ascii?Q?8ms+QuGgEHRNwb53V3KuM+qnr1hzd6UP2S47dznEdXF72C/PYquNo3/V34hD?=
 =?us-ascii?Q?UPUZyTzI6vRFN+xmLO2sQDuorrV5c1vt+adf3E5IO4u1DcfR9IdZ1sMzb+zj?=
 =?us-ascii?Q?GrQEO0RvTDUQhWYpGR/2+uHEMYzK2Kgh+d/dz1iXGR3CU1z+8ORxKmFI3jj9?=
 =?us-ascii?Q?nu2maYTUDeIx/iGRL8ex3ElYS+cEH8YWR1cOwV59hlCVjB2PF1kNlZfmCOid?=
 =?us-ascii?Q?IZ+vvufZ7ZJCzr27UNmyHwrNbUEeLviTXrOlQMWeHMLDIOKZia6kDOd4tgkW?=
 =?us-ascii?Q?dTANfsDfKW4QgvkBPFW+33azS6V29f4wrK6UbPJWnhFv4cQeAf2nbBYn6epZ?=
 =?us-ascii?Q?pWaznzHmHkAD0io3QL/cwkrOCUc2/OszUZNNHUTH9R2VFHIk08Q4ALzNz9+u?=
 =?us-ascii?Q?atJw75lewQ13GYTtqXHAMkrfmpD8lEsabLEIQuDT9wkGxnA1QmO5PWKrx9DA?=
 =?us-ascii?Q?2woJtZLEL7GkVgnv0W2PehpmmodUZBmeCaB34FlTnaxNZSdUnUexFN0udP1k?=
 =?us-ascii?Q?oMKCCxnMf4LM/U4hMJqa9bOYRTUfFH/rUUgMD56SdsaAKGbnVHeAaUgInJEH?=
 =?us-ascii?Q?U2buZ2ytIEI7b0nDcbJhMUjw0fDh9reh+Hz5UUX1rW9swgPIxvbmrGMdjBmf?=
 =?us-ascii?Q?KBWpLydOx//ZQCMR8H3b+VMFEtK2wTM9Pf0ZEntR/LK8LY4axh7bV5wjspiE?=
 =?us-ascii?Q?rB3gsfaX4IW4WMn3/5IXKvg23sni42cC7AlrujKzPJldFEJnQ/KHQm6bO7O3?=
 =?us-ascii?Q?/6bybS+lA4vQQ3/JNLlWPd+8b1siI0eYEWmkChUbXQYi1pCDqOjZb2FEYm1t?=
 =?us-ascii?Q?x919fPsRLquEj2DeeLjkWuybupb8YdHjbC7MhiNkSN/FVAOZINc8hBINLtE1?=
 =?us-ascii?Q?pLkVg3FyZf/P7V3wW9RJBAh2wmOU4mt/wG8027nBHLasDwge6ZLuVxCp8PD9?=
 =?us-ascii?Q?40BTyPMSy/7eEpWtKqjr2ltHewXYhfo+MiHeAwSwQidPxgdOuy2Erv3hduTp?=
 =?us-ascii?Q?cyFl1hYISSZV0sPLR0OJX9nEceI37OzfiU6OceNxmb9yoVgIBAM5uE4Bd9v3?=
 =?us-ascii?Q?N10zxNeRMZUKPAwIRxycT5C/yzLjidXPhQjd7MzE4j2+0y1AbScMNlMZ2Xda?=
 =?us-ascii?Q?z3VoL4F50nZuypV02TLP/GZW6luvsE7JxqPNU+B9RZuERlFMx7wGpaviOnxr?=
 =?us-ascii?Q?CdJHH4UEs8L7RRAjDVV8gtw3+GTcW0MCAHuVg5NrhXQfCwJZ/fTsZvnvwBkD?=
 =?us-ascii?Q?XI1n4rDQVViYwQeZK7x8cUIFm80yCa8/5ob1020UyFSe98ymzk9yIgWIVF4V?=
 =?us-ascii?Q?kEWVw/4K0zi0erAsAuOnnsFKepLeGdruhsNODjyhDrQdhk4OcLOLElQIBhEg?=
 =?us-ascii?Q?b99yUJ7QRaEFrwibhKs3NRPVYvwhallpItoSJBtN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f49a9e-15cb-41fa-f919-08db771f266c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 14:59:47.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuCUp4PwG1lon8C5a03CbDXoHXJhgBmhetPPQbZU1hVphnars6GL6mVxsyvfysQh+Q0JA623a3uQTKnTbc0Jtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 15 Jun 2023 07:51:16 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > ira.weiny@ wrote:
> > > I'm submitting these on behalf of Navneet.  There was a round of
> > > internal discussion which left a few questions but we want to get the
> > > public discussion going.  A first public preview was posted by Dan.[1]  
> > 
> > Apologies for not being clear and marking these appropriately.  I
> > intended these to be RFC to get the discussion moving forward.  I somewhat
> > rushed the submission.  Depending on where the comments in this submission
> > go I'll try and make a better determination if the next submission is RFC
> > or can be a proper V1.  (Although b4 will mark them v2...  I'll have to
> > deal with that.)
> 
> Make sure your SoB is added after Navneet to reflect that you are
> handling the posting to the mailing list even if you feel changes are insufficient
> to merit a Co-developed-by tag. (no idea who is doing what :)

Apologies.  I've never really posted for someone else whom I've not
developed the patches for.

V2 will have my tag on it.

Ira

> 
> Jonathan
