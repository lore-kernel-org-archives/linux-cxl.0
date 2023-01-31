Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E6C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjAaWTK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjAaWTC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 17:19:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065D5A807
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675203527; x=1706739527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m5kPEv2Yu6F7PRUvO32rCet2ROYnY9VYCqDw2MEQ7UM=;
  b=YB/JNFwEGTciNabMl3EDHgBrPVprqCTWukQx0aML0h+2qH4rZ73YMOeb
   hNP/XbxPhhkg+xpEJCB3LpJVLy5+CdBdFXBOyVpb74yXyG5CaMmH3YWGH
   DA+q4mv2hxwmSLXDXJ/OJC/O6B6onYnsG+aVVPJpGNguY3QwCQ4AY1AuT
   JzXDbyI0jICu5PhhnrMDvyRK4S0it2z21py/3HxE0iQLOEEgv8M/MJu0X
   J2715aBTkYco+T0l5BGTecoB3VGu8ns6UpTGnd3UXiJ+rqpkfVgb/Ck7R
   w33p4vrA7grV97R17+r7x5wzVcsfV420Bbt6mUeZ+uXsg7ocrlctQ+lOx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308318396"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308318396"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788615550"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="788615550"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2023 14:18:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:18:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:18:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 14:18:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 14:18:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf7r87dIH5pTMne3muh16a9uOQVslTyhaX++/9ov+j2FIet6oM3Kkhf5Ea/YQCdm6qBImn4G+U0GP7p9ObmLe7iPsVIictQFEY18OY2Cg29dOgtGjmCeN3+ds6C16yYcv6u31UILsbVwUT8X2ZImmAstPdLWGcGsa+JN3wr0d4I1yuCRVdegcOZhVvhVvPKI5hc8e9TWb1a0E/HKmW0CClxOsUz9hsXA7dwhvXuuKt+BMTCwEIsHDFbVgGk3KGvAazl4rNuovbtp5nmoYjeTF4k2YiFhUStL+tbt34azfoSPTYS/gdbDOpBquld1HjtjDFc6WGGVSHRcU68X+nxfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k55+VKsngtypW+Z0gjV+v6OqW6go7YOer5tW8Gt3Uz4=;
 b=FRHz7idZFUYrRy+OY+6kGtJypyvV8RlRhxgsJnkbqaaf4MDRgHqUJO0h1qXpLA8q/rm04R6iVoe/PLGHxX3aiTvhAJMwQM9hJZrKrewfXJyqwUQ8EmZSsnwJ4LN/fvad63SyYQnUFnThs3YYE2kx8K1tzuhZ+c5byP5clPx4Up1X9LTee5eKcwRGATkyiIPheqOSWRXHc4gFXxWd91vCTppMRfAp/tWULP9aA31/+4VltXCkTllA0UjEwjOa9wDjSGlYBt1wLFUigNchXU7ug1/VMs6+GLLIxXD60pn/FIrWgeT9lUXNKITQAph/Cq1SDKTikBXYsBtIm/RxWIlCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 22:18:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 22:18:40 +0000
Date:   Tue, 31 Jan 2023 14:18:38 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <lkp@intel.com>,
        <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <oe-kbuild@lists.linux.dev>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [cxl:pending 13/21] drivers/cxl/pci.c:511:8-33: WARNING:
 Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless
 it is nested IRQ)
Message-ID: <63d993bdecd01_3a36e529454@dwillia2-xfh.jf.intel.com.notmuch>
References: <202301291620.DxnDWLoW-lkp@intel.com>
 <20230130215514.6cviyuwhxgjlzj27@offworld>
 <63d991da1c19c_a8e3129488@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d991da1c19c_a8e3129488@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 422460e6-bfcf-4a05-6a2e-08db03d91ae9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5aevOX/457WZN7kyrU3OsoY/4TjhGKXv1+oQvf/BKRLp4p9cMySKVGkIe8Sw9JdO/ZDqH0WAl3yFs+kiKd3oO4k1VnIkLfMuoU1nEVA9dtgUMz0dK4MRGVhNrxvGRoMPsnn0sjkNDnF70hamautsqSReSimTzptvoIsGh6qpxVjXfNQPgxqTnGUnWNXI5Q5GvO8T1/AFXhm57Tcx2ngc+UKxMMitoqCqA2Mzcojj1abDnjpWpizNnbWWHPMkqaoNRQoKKjaZoBea38xWya1r3c+HAItXFl6V8L8XsCzGUnAbvhTGacIjpKYgVbOan9rxo2FSh70+CNww5L83DYgdYpz8bIonol+4q7Ze28efJKXDrUptbetAimWq0pXq2AupCKO6cRk8OwbVlhNl+iLqzYZrjlOI/tph2AB1iwsXiRAk1ClebuRSVLMJEe0PEfksSY0ep8g8OsXKO7OQezh+A+V9CoQ1q/GApIo1OfIZ7C2BNdvm61pUQKeqEQZzqfJjdPCy0554rxuaRosTzlj/T+RvBY7n3Qfc1fK5BjKZdLFLlPfkPaSC8N0UzJrU8EGUTVSQKyYsHTxT3gaMCP89w75z3M+q+W+HazOOg2FD0DEL45vJf2ymYWwvUTMbEdZ5RYzYCMEiI7YUPsRa+Dz3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(2906002)(8936002)(316002)(6506007)(82960400001)(86362001)(38100700002)(6486002)(478600001)(186003)(26005)(6512007)(4744005)(9686003)(110136005)(5660300002)(83380400001)(8676002)(4326008)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cvxnagiCUHF49cyKpQbIoZdZigFAZsrKj8EOOIJzVwwdhy+yvT6VBPDr5IQr?=
 =?us-ascii?Q?ccrqSz2JwIZS7xqnW2dFglxHi2LEIHEdgwC0UkH9t4FhCjdXSDdOYfhLlMgJ?=
 =?us-ascii?Q?lD4MYldJNLcp3XVThwhCJn0nUqzsg4Aejp/McYkMGBq6K1653E3uhDzQLFyy?=
 =?us-ascii?Q?ZUFlV9BSCRY5J0uTV3/JalQPMzHCoCrxPNb5zjzeInCb/NqeiSuxijmiZadj?=
 =?us-ascii?Q?TzV9XvwIziXYEngyPvwfLUASMoUcbjoVoI7mCpsJ2lJmmhD7fHMSBYv6tHoH?=
 =?us-ascii?Q?2HHJq1OxkP6f1zyWm+nj9wgZ8dgjYz/qi0CsG9JGMQcUPq+Wh2/n8e2OoOKc?=
 =?us-ascii?Q?OTr+AU2def79JKnNPKfUsFHwm0/gmSIbjZ1txuTxVMS/CsskahkrfVxSDTrp?=
 =?us-ascii?Q?wTfvMoyMMz6q9w/KDzGItwcn2Q6WY8nfxbiLvKCGsUO48Zeue40p6xxpLM6F?=
 =?us-ascii?Q?WcOW6XF8nKy1sg7WXB1LIaGxKY5NqyG3/l/vZaBHVWDgck6heYxgkkuWBzlV?=
 =?us-ascii?Q?OaF33qibw65fRgQ+nhXj8QdJDdGFqiZNw++42MpuWb/aADbbErUhfUjdzgBC?=
 =?us-ascii?Q?9G9X0usZr7a7awBEs2NM+pLRO9Oeh9BGX90PN625ZaApmhkbYzIp4Td0EKJR?=
 =?us-ascii?Q?3kKqD8otSOgerq+x2viTiJXdqfeZo3MEJcg8rqBTApmAqdubILp58ZWAyEQi?=
 =?us-ascii?Q?5llXZX5y8OW8D3oNkfvAZilOxj1l1d2YJFMFZ/g59LuTQj+Dy2vLjhC0pnvB?=
 =?us-ascii?Q?Q3TPeZL2NUkSAVWHN6h5RCyyzJfxTzmqN2oDkpLG+HSX/il3PfLk+c7HYxX4?=
 =?us-ascii?Q?MbfJICjnGeWY9UUuDRZX9PCrw6TsFgYQnRBlHvBqlxSRmAk+CWq9fIVdGv9f?=
 =?us-ascii?Q?zoCpXWGfwbRTO5bRgZHMIsEhmq3nfJfD4L9XOsDNpZbB+nV+QvWqCBflWXNq?=
 =?us-ascii?Q?VEEsZTdG4b5fTTiuOLkfgobH+oHEpU1aidSHZoeTXshcgRvqvV2yM5FFUf8Y?=
 =?us-ascii?Q?NXAYHXKAhswtRsBMqnsjOk8CI/R9mEeJAJuWUE6Wta5xmcX2GiCQteuvwPj+?=
 =?us-ascii?Q?37D+yG4zVfx+IQ6DuCav6cfZiJf/CuKKWLIaqRrufGT/PVWInHDKZSj7I8Ps?=
 =?us-ascii?Q?Js+T6pg2LYlv4oOgzinBOUWDH6simOvi46yUHzfHj+tJxdXEyKgYxC6OW+xL?=
 =?us-ascii?Q?lvH5l5EBSODL599eADlgNbE5KhKiH9LnLOQUK8xQCk1IMNkQo6L6pXAA+nON?=
 =?us-ascii?Q?ygnn7ISdbZtg2N4GZewnO5oMHnqKaCAYJjjjcJl8FPVHOHFmbuANyxIrgHBR?=
 =?us-ascii?Q?pz5ZnUAprsHLh54W5a2um5rprGEpIs54q5Gal5AF2aqdF6SMXUI8NcitVbNI?=
 =?us-ascii?Q?oKCRZA+36crRcNjgYfngC+O60mdCLv41Qq5G/HGJhF5jvhZKN09dcSRozGam?=
 =?us-ascii?Q?vlkQi2m+rVTD1IBWXl2M2aUraYpGukEwmKoLTbN05u75ZcOvpHl6jY+7oMFy?=
 =?us-ascii?Q?GhOKvNr4JoOf8lt3L4qKhiCEFyfVSZdXRPT899Fy3l8xyG+LjeAhf4nHH1f5?=
 =?us-ascii?Q?mORWO5I5paBKdVnO0Yit3xolyBDwHuRmFOhNGdlLco6GyfjEWzo1xK5nUzSc?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 422460e6-bfcf-4a05-6a2e-08db03d91ae9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:18:40.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkrwfwNMx6ZtIuSZNA6SfBbwxgiWOZIPySW9m2eMxjDO+jciUAR1Tda1QFKhxwvjoBVZ8SYkdWMowyIDeS31PSx5GHGnCUiUdl9Fd/3bTto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
[..]
> > Considering MSIs are edge triggered interrupts, this should be benign.
> 
> I'm trying to understand this a bit more.  So I looked in more detail.  I
> believe Dan suggested that I could use irq_default_primary_handler() in
> this case by passing NULL.  And this would handle threading the irq
> processing for me.
> 
> It looks from a software standpoint this should work.  But the kdocs
> really imply that not masking the irq in the handler may be an issue.
> Thus the 'requirement' of using IRQF_ONESHOT.
> 
> Is this somehow different with MSI?  Is this a case of the kdocs being a
> bit out of date for MSI?

My reading, may be from the changelog and not the kdocs, was that at
request_irq() time it is difficult to discern level triggered vs
edge-triggered. So for the default primary handler, that does nothing to
quiet a screaming level-triggered interrupt, just require oneshot mode.
