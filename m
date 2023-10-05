Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DBCE92725
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjJESKB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Oct 2023 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjJESJX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Oct 2023 14:09:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C579D54
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696529352; x=1728065352;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YQg//xEQf2s+cwmjQV4TO/ALWdXLn9yhdE2qKZDvc00=;
  b=iItuV7dfllPlNbd9ZiFlbwwyOH1qxkDTsrx0ypUVBcKkx5zodQKb2hwB
   xCsdGXXiH7btm1Mqa9kRXPIKs6HUcsddPC51zvIRpodUqDy319ooBF+hi
   jjIJlVHeS1lsEKBijvuRtplYaGm67zue1R102VwalksLLiEQrN6Rvq2Gq
   rLzVznTCfi9STV9BCm2efn8YbqqnxeswDseiAeNNDoJu3ZlCo3b4dARXg
   zoiS7PEWqbXpOXhZZ9SDUMz6yuVlq0Ow7N6x7L+R7i9GRtRkhGq2fhMXI
   HY0KHjwxMJJW8HdSWsehZKhSc368V/RfmV2kRkY0quh4WR5YodxJv2Y0q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="362933112"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="362933112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728535430"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728535430"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:08:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:08:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:08:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:08:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhHlXERytfKTLKdjNVw7d1K2Oi6yYxdU4M7VgYsUOd9VvWvzE4yCAtwsAyNwEAFd0w0qCcDyPxU+7uhWA3yasOI4YFXy1aVS/buJDt2tenma3ZU3WJQLstNlWQOBOYf4SX0xhIsZwRzZIAB0byBE182oWalEnTCaj61lv9SkFrwY84J2pVMHlQgYZ9fvCHPnPtiLMNAeKs7z7uelYxjGfedmc2P9ZolMf34oYnpzchGFlIZtnI72iU7QgC1wKePAkjnExDqGASlBrirTVkDGlugmi7/zLTgKTImNMDKMLweZggSR9gNGniVfw6miPw14dJg+ZD/KNE6ycxsAqzrF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TsgeWN72jTCumh8dlLSgUASe3UKbJ842FLm3Yz83MM=;
 b=K1sJiTIMhLRaliU5e07Y+0/m0EjIBEfoJ6dN1IdTdA1H6NOVVoJSkJ2tdBwJwhjurJ07pv2vcBuKTT1kA7bny0+/LSsE1atChmuc0RsBts8CUKF1EjZ71OpKZ4kL2WbLoELbnDNZSZuxCxkRKzaleQfAdxADf0sEUAhPxpcwqaALTf8lz8ejv4JH6PODpvt/x60eFK02C0qC/v+Fy1M8XMuy2BZKI7FVwgniW/LtKAXHbdYduap0lS2D9kgbSBlw0LYe62UhramzQMkQMfMGZoMLF5ydrKfy+v88NNLWxClKUldjUef23Bf/unujnVNJEXKQmTUiXk9CqTRRnIYTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 5 Oct
 2023 18:08:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:08:35 +0000
Date:   Thu, 5 Oct 2023 11:08:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jim Harris <jim.harris@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jim Harris <jim.harris@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: set root decoder granularity based on region params
Message-ID: <651efba08a32e_ae7e72942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
 <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
 <651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
 <A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
X-ClientProxiedBy: MW3PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:303:2a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: e0115d0f-e1a0-40b8-4175-08dbc5ce1758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxPnJsORHvpqbKQ6cBDf30gekpOIn3efQ9fmvgmpdSRC+ggJw+UU7MyMRuxJy3jANkV2W9PGE0YjcbPMRKpTvNjXVUFVvB8TulRsluwvOMwbQHddxTNZ1a0OIovfPvkcRabx8Aj1X4pTzrnt233A5dkEKVjYiokDCjt24du0iZCrAmKMYT9u+uy42JsCeg8CDWk9rRF+LyxmRGXGUWzR6vNhm8W1hAJ/0r6h+bPsIFVrytWJh+Ej/pcPsw6lHyqTdp79cNZb0BidifFgjbXX2Yt93USynJrR0ra249pfxJWBcWaBGt2YsdzXXImkRk1PhqAhf0oB/M0Z3KRB4OIlSmNU50wIuiK0BEE+SZtoQGJqgegrbhkMAPzrvKyDuhfYn/4ke4wFE+RBrmsWZ6zBLSTn31ICXHsPG7vYR+uTRHX6zexKMl8IGc+WBdfeNdEWFO4tiwUIoTEg21kvkP9UGsjShJFfy4rnO08091wbNbNp7HGq0AoUl8Q1TYB/1Q6BANZ911VXCk0XsAGchWutXslMCNQkIwl1VVDoUVvVmlBKzE+v3DkcoIFx1saTlo8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82960400001)(6512007)(2906002)(5660300002)(9686003)(6486002)(6506007)(26005)(83380400001)(66476007)(86362001)(38100700002)(66556008)(6666004)(54906003)(66946007)(316002)(478600001)(4326008)(110136005)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpxcStkZzBmY2FacGpMekpTTjMwb3hMSjM3cVNTM0Rsa1QzcU42cGJ3MjJk?=
 =?utf-8?B?UWhDM2ltN3gzUDludWc5UGpRQVlYem1KdjlWZnpMbWMxTjV4RExNMk83TmUv?=
 =?utf-8?B?Q2VObnRwNnZUaHNEZ2lPaXAvbklGWjhhSkdGV1A1OUF4eUNMVHJtSUNJWFQy?=
 =?utf-8?B?Ulp1Wm1ra0Nra2oxenFyYVVoWXlyTFdWQlV1bFplb0tyeUFKUzg0SW5IRzBq?=
 =?utf-8?B?cTNBa0RYMHBVNXZ1ckRjaE9vWnNaODlDR2JVS3I5dU1qeGxDVXdGTWY0UERB?=
 =?utf-8?B?aFBSYzAzTEJiMkFsaDcwMXJncnBsUWMxdnIySysvMWRjOHdhdmVLY25IWlho?=
 =?utf-8?B?KzlmWG1NNElGbU1HeUNyMXVvWFV2QXNQZ2lzbnZsK3llNXlTb1VsY1hOekZS?=
 =?utf-8?B?L3FtZlQ0a2o3YXAxU0xOZXNqWTBTZ1ZlR1FYZEJJaWdEY1VvampzRGFIT0Np?=
 =?utf-8?B?LzdiMXNuRkNaSzE3ZnhzdnhWUUFLTW1HaGFETkdHTFFEMEVMTUJ1WEtsVnk3?=
 =?utf-8?B?UE90d21DUWR5bXdubjhHaFBtdDlKYXpnQUhlbmhnQ3FzZHluTWp4T2swNEtO?=
 =?utf-8?B?MDdvMjVUeHE1djhRMzE2MEx1RldBQ1NqZVRreWJJUzJpdjF6ZXlyWWhQbTQ0?=
 =?utf-8?B?OU9vQktkdkZZTEVwbE92UWkxQkZPaXBkcFEwR2c0TXlJaXMxNUF1RitBbnhh?=
 =?utf-8?B?TWhiKzFLd3cxZGwyUE9uRUpVNVdTbGRVTHdXdnYzU2l4ckRWeFc3UnFJQXVW?=
 =?utf-8?B?VDZrNWUvQkdjYWhJNWFsWjR0RzdZalJYVHp2dW5veE1zcVZTdTY5ci81eldK?=
 =?utf-8?B?WWNMcjF2ZUFDS1FseS8wZ2Y1VEJjckhaQnZEbXR1b0hjY1hHTXVZYlUrcWsy?=
 =?utf-8?B?SjJQblFIV3VrcE91Q0dKNFh6SlUvcGhDT1BSNGMxZGgrcDRmVW51T2Nob1RD?=
 =?utf-8?B?aEJtMi9Jb0ovVGo0MzI5V1prMmIwWDhFbUpyTXFaOGdGU0VtSkdub00xOHVK?=
 =?utf-8?B?OEdRVVVaUWlpK3huR092OXYxNHFBbjhJTjlOQXpCamdLdDNFRGlIVWJlOUxH?=
 =?utf-8?B?alR6RFNWemY5NmpYenlWZll0eFFRU3J1clFKRzBYTWFGaUNJd0FkTHVta1Ar?=
 =?utf-8?B?MWlKRjBMWkR6Z2pSUEVWSkdGSTlBUlgzZi8xeVhmTjJkZ2Uya3JNbWNvYUg2?=
 =?utf-8?B?a2tNLzZPNVUrcUFFWmNRR0JZYklWOGRTbGFZN3pQRHhhQk1kWGMycnR5SzdM?=
 =?utf-8?B?N1BORk94c0VVNk5kaWRWMWpkN1o0Z1VwVlFMRG9kVnRZVGxIMDQ5R2ExVWZV?=
 =?utf-8?B?TDM3QWtJVGluTEltUm0xTmVvZmp1ODgyUnFjaURJZkdmdVlVNSs1MlRSZjVw?=
 =?utf-8?B?NDNSZHNTcE5scUY0aTZzSHJ1UGFyM0FDOVU1VUhiUFZwSDJHYkpVUGRhaHFE?=
 =?utf-8?B?N0JONGIzU1A1R0g5RVlpUFVyU0ZPL3BaM0VVMU4wejNMSDV1OGdQNUJGayt6?=
 =?utf-8?B?YTZGZ0F4R1BWSkFDMzYzcllQbmVZdmo4S2tmUXFHM3hWanBnTDdIbGo3U2lI?=
 =?utf-8?B?QUZWejJzQnAyOU1HNEVwdmc1Q2VXVXlZNEJVNitRWHZnSXBkUVNiK2FKV1VK?=
 =?utf-8?B?MG1VMXUwOGw5b1RWVXFUZVozZ1crS0NlYTdBemhwUVFweWVTZG82Nk9xQ1NS?=
 =?utf-8?B?Z2xaVmZWTXNNNWFqZFpRcGc3THM3QTZwQUFYTnMxa1JPZWloV3FxNkJocURI?=
 =?utf-8?B?bEplNUUvS1BkdjNjRUh3THl2dW9PdVJMU0g4c0FLdVVOekhNRitxaElYUnQr?=
 =?utf-8?B?VGl2YS9QKzdNa01nUDM3eTMyeHVmTWovSEpMYUNPdFdBOEJySmtQL1pEdFJN?=
 =?utf-8?B?Ty9MVklKbWdrazMydUM2RjhJUFVQNGdjTzZ3eUJkS25hUWozbHFnYjV2MXZw?=
 =?utf-8?B?b29EQ0RxK052YXhDY1c2NGh2ZzRnclV2NGpJVHR2QTZwSzgxdFZlZUR4cHlr?=
 =?utf-8?B?U3FqMWJ6NUhJRjFkeVR0UlQ4MTFjR3NNVjEvZWlZVHZqWDdndHQxUGZKOEdv?=
 =?utf-8?B?NHJQNWV6WTRTV0JEenhGVlZ2ZGlSTi9wTVlsNHhnL1F6bGJ2MXA3VGIwMmNu?=
 =?utf-8?B?TmU5OGJkVnNJclIwYURocm1PRkdRT2NCNlUyZHdqTmowdWxPYk9QbFNpOUd3?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0115d0f-e1a0-40b8-4175-08dbc5ce1758
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:08:34.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oytYuTC4e7XpmD27pB5hQe0KHy8LwiSMFsPzV2ve3wDLUFsTg2J+xDIx7+qUMPc8AH7A1wAd3bZejuaDC9paFghVFIt5wMgBFW2toepSsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jim Harris wrote:
[..]
> > If a BIOS tries to ship such a config in production that's when I expect
> > that policy needs to be revisited, but outside of being forced to
> > reconsider that stance the complexity reduction is the benefit.
> > 
> > In the meantime maybe add an "effective granularity" concept for x1 root
> > decoders and x1 switches so the math can use that value?
> 
> Ack. Use “effective_granularity” (EG) for the topology math and
> “interleave_granularity” (IG) for programming the decoders.
> 
> For the x1 switches, is your intent here to set IG = 256 since the IG is
> really a don’t care from the decoder’s perspective? Or is there another
> reason we would need to track different IG v. EG for x1 switches?

Hmm, I see what you are saying. If the value is a don't care, might as well
just update interleave_granularity to make the math friendly. So "effective
granularity" is probably just a documentation update to the 'struct
cxl_decoder' kdoc so people are not surprised about why this may differ
from CFMWS value.
