Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E65C05027
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Feb 2023 02:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBDCgm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Feb 2023 21:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBDCgl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Feb 2023 21:36:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7464709B4
        for <linux-cxl@vger.kernel.org>; Fri,  3 Feb 2023 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675478200; x=1707014200;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Rfo1TRtnyrqL41HsYrqPgLCxCiN/ykUWejzY6UPrqNo=;
  b=apC/NjdjCVFPrFc+muN00FXjiu7/RS0Z/F5aV8Syfj8ba4ioQPzHqOVL
   0OVrto8T1c10DpDAbkZWnbiDJamy7t6Je7aUVIhSHBNMRtQ3sGgjq/1yR
   c+rWXScjmAzaIL7OpQ8oWbfiGmIu0FDqNulHCViQ64WTLaePuAlaOIM9e
   Nq0wv4bnX1qtKo1EKXQUC8eBQJJUzdaoe/xJWqKSQkIec+LvG2sgE/R05
   rUNOy+umRPRtip8kPkN9IctEB5mQCeffMsOuKGJn+A16SWzZv36sbZHO+
   YWm3PzhlIbIItCA3zW7RXQfeMMseea9R+dH+xZX3nZ4L+hnDWd6r4tmml
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="327544824"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="327544824"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 18:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="911358432"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="911358432"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 03 Feb 2023 18:36:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 18:36:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 18:36:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 18:36:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5oTzoggSXJ+TK6hT8Hh5HQd1oWflAqp8hTn6/++BVDhd+kW6QJ2nK5SlFPSCx1cAD0mOPpyPrR0jJW/hDTL9IhZAxRJ0bI0b7EZMcTwzA+LtGG3FJmuywcvi1BLK3hC7r2TqqiBflmldbZ7/1bup9yG9XCv4/Qt4M2homjhDoJqu1g/Xr88H58kiuioLB4yA/G9Y5o0CVINUkUvSgxmmdAJSZ5S1DW7T2of402mSdvTMglJAUbmcTOXjvc0hOj5DspPfGpmDf3q74WFjdJ5NOMUITxE7MaqNcDgXrwO5AnTYZ9lkCpTYro7EErHVCNmciXb91oNBx7TwGsTDADHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCW1hU7k5tuEhfO2nQmzQVaqLetB2BtgVQXxaeFlqM8=;
 b=mKZGaY3g0SWViigb+I2cWMGGV6LqFv5jK6V7dytngy9uJ+r/TPa46cDi/8rGKKWZiS3nGzw3ZZHNCnfj/etVsqayghxW5cxdGHJwgeo9qLFTNZIJjC2ugURjOczNq4i1t2slavEUm3axZAcCOeIvDsTCGzYQmrMO6Te1PJh09pDwb48TaaE12zQDtugpP9A6E7QFiA0voRQzNJSXU7Wv5O7iCRIqN7Z1Efpd9cz4UhREnDVdpjUv7gTgTbLiFtQ8j8UQSUYGSMZBC/Qf2VM4Z8yBFkrZpXryYXyEGJcC7N6kpqVrYaYk18TffVlVG+TaoXQ0PhIxl9FsDF8N8WXn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Sat, 4 Feb
 2023 02:36:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Sat, 4 Feb 2023
 02:36:38 +0000
Date:   Fri, 3 Feb 2023 18:36:35 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63ddc4b3364b_ea2222940@dwillia2-xfh.jf.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: f47fb730-3f26-4238-5434-08db0658a3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+e+8c3neps4cckYsgKqA7x0OoRHcbdHaFqP4EZM+C4dlrf0qR23nBDR8dPw3cnped5ZJ/ezegIZ+l6Fhyx+5VsoHs/T0qM3EpPQbtLWeS3AZHewEwDYNx4GdvmfM962Aa8nR1L/I410QWP6vtTlo07KEbRY1+nztrm45WwCTMnLV4ffLJq8lJCmoJNeOXNFTwvaMD0iCtDfXEMnyHzhh7mUQzWY09nh6zFUDilhEu6yaVtTVERsExDeBz+E3CtqD5BhzYBNDAgTrdr3vRZ9XFv3OJQ5zfWs1SsK7meuStTIAeFWnD6g2AVsXwSRbQHRprkXgUbAW0/2HtjOQEITvntoDi7xmnwiePF3vtr35uQpIn6ijz3KjV7QsVX6Ao8R5fDDxCtm1jCgX0WlpPwOG8RXgmcCb9dGAJYMdr+Bm1YefKyLPHtrAJ0kKf3s+ScMpQGDsl3BX3zXjrurK7zR6cXS/F8jaHfTYD3ToLIRKUev+pgu5nXiN0xmQmdh3kw2I/sq7W1F7QHwHFFHtAnjVZLilTgKiwNZmA5XhODJIN+Wl4NV5kP2CSK2wdPiLHfEtuT4ZPPKci4Ki59ssLa7RDyEJS+eCSSf/ZcsOO2bEX/CeOGbIRTLCmxfXLdkmuDmWa1sbhiRHa3Veczr8AE2GOG1FXiEx1I8/GrkRKxIm9I1pN0OA4P+YT8JLixWqKi9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(86362001)(6506007)(186003)(26005)(9686003)(6512007)(478600001)(6486002)(966005)(6666004)(2906002)(41300700001)(5660300002)(8936002)(316002)(66946007)(66556008)(8676002)(66476007)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zpLYnCpLNFFQG875pZWb1a2Wotk5AnIXbv6nncPpdwO/ZevyESXCpMlm7/U?=
 =?us-ascii?Q?YC4Htb2xuzA9GowZZ1CnBGqhjc2kDrWlJJ2UnarS7GCesrs3sxk5bXNEpuOL?=
 =?us-ascii?Q?cYevzKm005BMG/DhmlNNUztwuXtNwYbSsPT+iXy+oR+GCsF2QBS46hCcPoag?=
 =?us-ascii?Q?izPtqLK3ZYhCCwAcsapWQl/L1LHWF4WwwAUtYYQXqY87dv/+fTMrg5I6Fxal?=
 =?us-ascii?Q?NM3o2vAkETbgDphFufevmrWPp5ZNLScapyK/WAJXaS4Lw7DEvsPU7gltSqSG?=
 =?us-ascii?Q?RkBsiL0L+enGlNbNzVKA8xozPVwCgG3Ofj2ebAzW2oYX22wxh6ugq5HbMzYG?=
 =?us-ascii?Q?qDt6d/u/U7p+auxPRkgPEUyQA3UdQFEll2MJJ3Qfn48QfJSc2AMmgSq0+M44?=
 =?us-ascii?Q?nku7V9Va/EAnjOVKI2TFKn8MCVlTMUT1PhOeiU8rrCwhDtFv7JmJdK65eotj?=
 =?us-ascii?Q?vWRi1+fELpC4QgHA72jx34Fr+vNnJJCy9rm0H62FtOTy/Og00HNnOKShGeZp?=
 =?us-ascii?Q?LsIJf1Yv5Kw0l3WlDpskiL9XH1SeNyW4RLF3e1L6DxyvD3Z2WzrdHRzubLLp?=
 =?us-ascii?Q?ri1qdfMe0m8C3yy1lZMs5Wk5guzMG06jkPRlpUBykKAjXrrX3xGnCRrfqsDk?=
 =?us-ascii?Q?+IjwFXtdwt6KDlJ9a8VFtcWYafj2eyNTTb5IJlTHXSdxZ2QAhb5KRk14LYpL?=
 =?us-ascii?Q?d/hG+uHyJDWgRnSbOB3ZPTRVtgUBA0T+fYU0ROWEH+S7nAEwIHYpCcxuBrIo?=
 =?us-ascii?Q?1qadSg41UpR6XPy74+KvVqgr8UMf6p8Lsic+tF4krkjkfO8k41cwSXK0hcxd?=
 =?us-ascii?Q?C/FQp14I6GSXh+9R38pMN8xalB8WqMfYWC8SpBN2/d7UjLDKYeB60rHSfZGe?=
 =?us-ascii?Q?H0i9S3TYw+qBIxTLUJ8DQxP909dAxIEfEftBPtb1vt7KKORH1NkmtVuX88XQ?=
 =?us-ascii?Q?nfeRCVDM8/dBGU0wGI0QZFfLjmvhmoRtEJsqm2pgueCKKsmOFqNbsIEFwk47?=
 =?us-ascii?Q?J35ydN3Y7mJxkl4IWiUHIaa0K38cfFfXnenkaB2YmahkWopc7muC8MqhUDxh?=
 =?us-ascii?Q?OPWPxwcd8llmydLbUrE7e8SlHoXD8vUUWSew9p3iBGGVglCbmmW90rXAJ+Pg?=
 =?us-ascii?Q?A56PBAmr8MuhCLpOfURHackBQI9sRV2FLqKCuXbp4MKNn+kOaOoQpTL/aYAz?=
 =?us-ascii?Q?E4mR74m/mpqi9EK692qFnwYq+y/Nz0fMBe/5AG/hceI4Otfn1A9TfvB/AOdw?=
 =?us-ascii?Q?qZumiH61pLnb3l14qqvhvM8+T91JMt3BO7aRV8FxMZIXRI0mGog9zTYNt+DE?=
 =?us-ascii?Q?+NmPWgYPpa5LJyh9P++tRSdW3wKWs1jqpr6Fo6LXglhz8ErZ1ZWad86hHB39?=
 =?us-ascii?Q?GeU8kBchrcqlRa83cymionTLRZjYav3mxTdwRPZhSCupyjp+HbmSUQ5rGYbe?=
 =?us-ascii?Q?KOdO+rdL4y1YsDfO9ys5veVUNBd+ptv+ig07yxP8MerPCyHYI4Km0+tHXXWM?=
 =?us-ascii?Q?lHeVArG5oBbqV+VUhxTvz+Q+KykmYKI7oZbxWx6QWHt8XG0wJ9yRMxiJokX1?=
 =?us-ascii?Q?Or+Fd55l+BJVS9SZ3Nu8O6djnCsrCl8888yMZj1eLaNlxVzIETwNEAW1zHip?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f47fb730-3f26-4238-5434-08db0658a3aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 02:36:37.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwbUAnBWZVxKPkEdGvEWRDB/xGgk8RmqtuDWPjnynlAafBZaSHytxM0KP20UnyE+G7XHCJi+TSiCvwpdV36Xyn7DgdYJy7LA5hKcyrB4+e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> There are still some sharp edges on this patchset, like the missing
> device-dax hookup, but it is likely enough to show the direction and
> unblock other testing. Specifically I want to see how this fares with
> Greg's recent volatile region provisioning in QEMU.
> 
> I am hoping to have those last bits ironed out before the end of the
> week. Note that this topic branch will rebase so do not base any
> work beyond proof-of-concept on top of it.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region

I have updated this branch (14acf2db2613) with support for routing CXL
regions to System RAM. Will send the patches out once the build robot
finishes chewing on it.

With cxl_test and booting with "memhp_default_state=offline" (since
cxl_test is not real memory), it produces a device-dax instance that is
ready to be onlined via 'daxctl online-memory dax4.0':

# cxl list -RXu
{
  "region":"region4",
  "resource":"0xf010000000",
  "size":"512.00 MiB (536.87 MB)",
  "interleave_ways":2,
  "interleave_granularity":4096,
  "decode_state":"commit",
  "daxregion":{
    "id":4,
    "size":"512.00 MiB (536.87 MB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax4.0",
        "size":"512.00 MiB (536.87 MB)",
        "target_node":0,
        "align":2097152,
        "mode":"system-ram",
        "online_memblocks":0,
        "total_memblocks":4
      }
    ]
  }
}
