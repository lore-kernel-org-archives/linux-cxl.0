Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE5C77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 20:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEXUvc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjEXUva (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 16:51:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23612B
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684961489; x=1716497489;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qVSVo6Zeu1AihNlRM/Q5cENl1CkYXLI67vb+VzPbh4E=;
  b=O69ghB4FLwIGcnhECJvN9hzZM2kekBld673PWe1TuuJXpNB+RKWmbruZ
   wVwuCY5OdDO14T3Ehij8NHUB5RUnxb6JvrIox3rEy6UBMI5lK7lX1AaTd
   CbC3uFYTlXxMTHeu/Ozf7dBoKRrN46PjH2klHoOCCYRe7jaaE44cADUAQ
   ptjzRQo26xm20MuoxSHyYanTGzGUkxVAXtU7p2k+a0mS/0LuOL4whgA7s
   2wZy0LMGT/nYk3nmeffaals4LQW25q9At/1lRevfyziiTz9VFp0UnUcFA
   WTyta4jdKoUXlHtslwDgFZv43xP7T/rdqvRCkr36PPfkERrX1kdfO8iRt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="356042171"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="356042171"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 13:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="682046389"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="682046389"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 24 May 2023 13:51:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 13:51:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 13:51:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 13:51:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 13:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogS2fiyD45CqUFz8N+adkIAtI/rBSpBtS/EZawLGADg0trP7x3PZrn+VoEUJhKq/iRFvIm+GTZizS1cfcWfGt1HqYQa2stKmvfIda+Z/nd6j4/tC1z+177mS9e8UNsm+WqWprRHptH3qXfkhaJsu138nFDg/XeMg/SUVWunQ/YR9aLlPeBM7TAejecqSza9xYopaWLFnwoFsIJlm/MtUPwhdP0R8po5c0Gh8mCu8wS5B2cy22fNnPpJ645BoTgicVqW37DIhhy/a6Ui3GqgmtG81OO7VwZTJmabldTrR81gls1EL9yAEDAOJIFwHNJRVvyEpAMPglcTzD+95QADBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPRhIo11qD1JoaIrPyMuA/ItxgUFmJHKP6qPQjkLp/E=;
 b=HTi9LLGlCJj3TRgTxC1E5kbctm5wEI6I+ZWrcJMF24g0ZJr4igjONyTHUACiotKzyXjcNn/X1UnyUzK4R3kdrz+/hTKpheaxMNSR4Bd89Prikf5vYGST4ldkgp6FiL7u2XL6AW6xTQt7kRN85ROfV/p5oiRCKKl/3aAEXH4BOJg1pnSXgJdBhMIYaJb/jPuLBfOQFhYxIsW5Ii7iB1v3ywvqj9OQREfGNLobkeaCMqrY7DpZQhJp7HOLeyvYaIh2KC45CP/A481TKz/DBsKxtxDESZokyu3AXVku1FxTw4DJM6XWFW7o7xmdbMKqkTEvGgXnx6iapPXpLfMFDRPn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7881.namprd11.prod.outlook.com (2603:10b6:208:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 20:51:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 20:51:21 +0000
Date:   Wed, 24 May 2023 13:51:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <646e78c67ce17_33fb329432@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: aa656916-68bd-46b4-56bd-08db5c98a0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5d7TPUgyhsPxJSHlo2E9QWuFx4X6cOOd6hZACRRG/ZSF5CUsxz9jscmr0IeE1+lHqRsS3ho2rg6jWlwzAO0gPbV4h/ZfeIP+ZLrVT/g1f0829foK2AwcL8DRo07fPp9IOubEo1uXH5AsoQaii90Fcm2kFzvJ/Y18HxxNUouoNgpIEdc6CqIhM1/Eyd2fIwTZ1b9pd6BbmBoGkw8frf2R3IDJF/tVnBOJvbbiX7Va8hnOKFwt3/1hPDHhG3CiJZxeLZDoZzpiR2PeZwLnH6yP2f4/HFaOe/3mm7ha4XeFdepVtjv9qLoxGX47zUM8dXHyPUz0b4CQILYnyH4mXN9zktbRPEXpEOxSUXQzLMy3XH7D5+c+bl7QU3uXnMWXwiC85HBPnN1kk9DKOGXEZk956SowkPaM7QPKKlDHPelw+jT6ZqWLr2gyZ+AQfVghrKsIif6lIW1UIPuDlvPW9nMEh52jdAW5y67R3QyzZSzStb9d4D56jqE1X2vQH8eyqSZJR1DJ0W5cDpqVqSMln+1ahJD1VhDLF/+P3kxvzPO3Pan3JaBN9tk118F1iWaeQBP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(6512007)(9686003)(8936002)(8676002)(83380400001)(38100700002)(82960400001)(86362001)(6506007)(41300700001)(2906002)(66946007)(66476007)(66556008)(5660300002)(316002)(6666004)(6486002)(110136005)(186003)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ylk0dEoreDhGSnZCV0thQ2RDZDBTbUJQUTZCYlFkbFNXV1U4dFgvSG8zUUl4?=
 =?utf-8?B?VHVubHlpU0UzL2RrSEtLOVFyd1JaV3M2Mk9WeFJ4L3R3djJCSzRNQVpPSk1a?=
 =?utf-8?B?cG55S3k0MmpFbGQwVUJXNVdLNGdmblRoQ3hIRkM1OE5LaG04M2VQVjR0Z1pC?=
 =?utf-8?B?c1EzR0tYdHBQQXR0azM1ek1NRVpNaDgrMVo3NERTK0g3ZHBHVHFDVUI1ZnpP?=
 =?utf-8?B?N1RxZ2ZTUVJZTzFXemFSOFRDRDNQcStTaXFGdzV2RWNiT25yelR5UlAvdTVi?=
 =?utf-8?B?UlRTV2pEUE1HZnRaR2dHbkVpZTFoUUEwbjlTcy9pRWJValZMMzRobFdWMEps?=
 =?utf-8?B?N2hhd05LdU1EaDNKVExQODE4OEtjOUEwSnhqanR4b2lpSXd2amNmbXV4Uk44?=
 =?utf-8?B?MG93UHFLR3NQRTBUTzE0OVlRTjl3c3JSZmpJb2FUMC93bDdqNk5WRnB0eG9u?=
 =?utf-8?B?ZDlVQjlRaE40R3hWdlJsbTZSN2tBcngvTEY4TjJ4R3VJVXJSVEw1ejkzKzhm?=
 =?utf-8?B?ZVN6OHlCUXRTM0V5UWpaYVVwT3pnRksxdnNzc0VlRjlSYTVnbVBpc3JhSFZa?=
 =?utf-8?B?VHRmNFJJMlZXbGd1ZGJxS3VsWnpSbk1WSkkzOUp4YXpmRlREd3ZpUmE2U2Ez?=
 =?utf-8?B?Qmhoc0NZTnB3R2dxSnlMcHZETVNtVm10aDUvQVVKcFR5dWJMQlRWVmMvUGpT?=
 =?utf-8?B?MjB5c3hhQXB5ZTd5WGY5OHpOWS9TYmNabnovUmJYMG9FcVJ0cHcxVlE3dzVS?=
 =?utf-8?B?WlBrTVpNTHlWeTV4bVdNWVlLNWdoK0w4Zll5a3lJMzlqQjk0VkI0Y1RlY1Vx?=
 =?utf-8?B?Q0VRSlZIaXlXRG1Nc3l1NHFXOWRudDA1QnpBRFFwd1AxdWZKNjlydEs4Tkx5?=
 =?utf-8?B?bGJjTXp2S1NxNHlRNEJJNlAyT0pnVExBYXhJcFV0bGw2TG1KQjYzRGRrOS9h?=
 =?utf-8?B?d3pIcUpiYVkxY2s4a3NFSS9OckJJYXZmb09nK0tHdDlFOXZuVkhXcTBiNThX?=
 =?utf-8?B?MzYxemEyOEtWZHBLK093WVBFOHY5Ti9WblNIT3MwT1NYbldmbEVTc3h0TnVo?=
 =?utf-8?B?N1QvUWl2YTFOWUk4a1VPMUtFeWF6Vlo0N1JKZkVmd04wc3AwTzRqOW9rUitz?=
 =?utf-8?B?UWNiTGxqejFIYmFWK2ZXLzIzamlFU0VHRVV2ckdTOTdFQU5YNEY1TUJ1Qk5N?=
 =?utf-8?B?KzVrTWdLOTlrQTIxamZqK1VrRDdEUFpxVHgwOTRFR3VVbmpsK2dKY1VPdGNH?=
 =?utf-8?B?djdmci94bllHVFN2bEdxQUpDUzdFYTBMbnVPelEzbmc1dms1OU1ENkRDVDJJ?=
 =?utf-8?B?K0hSeEE3KzVXMi9vamowQnJFUjl0M25TWG4rTDJnZmdvYWx2dTNvMTRjTDFs?=
 =?utf-8?B?Mzk5TEhVc1J6M2pNSEhWR2ZRU1piR3hhZkNGa0RtNGlRQTdOMnNYMXM5ek5k?=
 =?utf-8?B?bjJqMXM4cWwwSGxZWnkrMTgvK3ZockhqWnUxUjA1eEVXeVhEZXVuY2VIVG44?=
 =?utf-8?B?TGxicDJQelhlalhyb3duN2MxUk9qR1hkdEJ4aWVTQjllU3ArdlBtWU5TYWJG?=
 =?utf-8?B?RWRkV25lQ0xQVmdwT0d3T0hnb1o5Uy9KcFo3US9qcEdoMVcvVkMrSWk5dGov?=
 =?utf-8?B?OU83TzNBWEZ6TnhTdG9vSmpORjJKQlpWV2s1NGNqUFQzbzNsT2FKMElXRE1D?=
 =?utf-8?B?cHgrZ2ptQThMV0o5Y3JFRWJzR3hoWUtKejhpMnBNaXhxRkVkdFlXVGxKZDJU?=
 =?utf-8?B?Ykw2MUdKU2VXTUZOK2VFdERJK1d2TzRVQjJrSFBMaGxyWnhsVDZnMHkwY0pj?=
 =?utf-8?B?MHZrQlBodzRRVTRzeFpjYTdPNHR0SElwd1NKSm56SktCMWNWTllPSnFBbDZ2?=
 =?utf-8?B?cy9HYWxPWkVQN040ZUhTMmpyaDJXOHZKZzkyc3JtdVBCWjhCQVFWWWM5Nm42?=
 =?utf-8?B?dmhsR0Rpd2VxRU56ME1zYkxDVzRqbmZlc0VaU0dqNm45R1JSZWNKYXJPVCsx?=
 =?utf-8?B?V05HNjRGeE9ha1VhVzJXRmlxV29LN2Q4bDgxaFhXcC9VczYwaTJ3VVlCdFZ6?=
 =?utf-8?B?bUpuNms0MmhOdXMwTGVkakJNNlJwVGk0VjBFWXl3NjZ3L0dGbDRhaDc1aUQz?=
 =?utf-8?B?NDV3NkpkOEMwUEx5MXJEWjZTRlQ3dkNGdlgrNmdjc2owdjFEdW5lUTEwMXE4?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa656916-68bd-46b4-56bd-08db5c98a0e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 20:51:20.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG/0PDURhestniUG7QU3mPXTt0KD/pUVQrLUtxSLaL3kBlfprHAERmKr/+WaKWm+6PG7apXpXE3GxKmWwxJhuuY6SdL+5r1T07gijv4RTI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7881
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yasunori Gotou (Fujitsu) wrote:
> > Yasunori Gotou (Fujitsu) wrote:
[..]
> > > If a block hotremove sequence fails in the device, its user would like
> > > to keep the device online to postpone replacing it or select other device for
> > device pooling. (vice vesa).
> > > I don't find which component handle this situation.
> > 
> > It depends on how the memory is onlined and whether it gets pinned by the
> > kernel. As long as all of the memory is onlined to ZONE_MOVABLE then there is
> > a good chance to be able to get it back. However, ZONE_MOVABLE is not a
> > guarantee that memory can be removed later, and ZONE_MOVABLE requires
> > some ratio of ZONE_NORMAL memory to be present to make it usable. See
> > "Zone Imbalances" in Documentation/admin-guide/mm/memory-hotplug.rst.
> 
> I know it. Probably, I'm the first person who proposed that kernel divides its memory into
> movable and not movable area. (IIRC, it was BOF at Ottawa Linux Symposium 2004 or 2005).
> Actually, my name is still remain in git blame in the empty lines of the document.
> ----
> ac3332c44767b Documentation/admin-guide/mm/memory-hotplug.rst (David Hildenbrand     2021-09-07 19:54:49 -0700   4) Memory Hot(Un)Plug
> ac3332c44767b Documentation/admin-guide/mm/memory-hotplug.rst (David Hildenbrand     2021-09-07 19:54:49 -0700   5) ==================
> 6867c9310d5da Documentation/memory-hotplug.txt                (Yasunori Goto         2007-08-10 13:00:59 -0700   6)
>  :
> ---
> I'm glad to see many people have enhanced it after leaving from working for memory-hotplug 😊.

Nice! Yeah, I have noticed that most times when I think I need something
new for memory hotplug and CXL I run into David Hildenbrand's work
associated with virtio-mem.

> In my understanding, one of the big reason of memory hotplug failure is long term pin user pages
> like Infiniband RDMA, and I guess that or any similar features may have same problem.
> Many CXL devices like smartNIC will have such feature.
> Because It has ambivalent requirements.
> - To achieve fast data transfer, such feature want to skip the kernel layer and pin user pages
>  to transfer data directly. The most of CXL Device like Smart NIC will want to use it.
> - On the other hand, kernel has responsibility of such area management. Memory hotplug is one example of it,
>  and it will be important for CXL memory pool.
> 
> I think it is same with the issue FS-DAX vs. RDMA, and On Demand Paging is only one solution for it.
> I expect ODP may helpful for memory hotplug too.

It's going to be interesting. Yes, as memory becomes more dynamic, long
term page pinning is going to become more and more painful. It's even
worse because it's not just RDMA that causes the problem it's also any
device assigment to a guest VM that wants to pin all host pages backing
guest memory.

> About ratio problem between ZONE_NORMAL and ZONE_MOVABLE,
> I think user/platform will configure that DDR DRAM will be ZONE_NORMAL, and CXL memory pool will
> be ZONE_MOVABLE. It is easy for them to understand.

While that it is easy to understand, I worry that is in conflict with
one of the main value propositions of CXL which is vastly expanded
memory capacity. The conflict comes if the capacity of inexpensive CXL
outpaces the ZONE_NORMAL requirements that can be satisified from
locally attached DDR.
