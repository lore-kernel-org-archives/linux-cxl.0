Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161093D90
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WafDt1XY"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD89A3
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 20:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696821888; x=1728357888;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=k6f/q+siQtuS1XNQ85yfDDKZh5VQ9Gmb0mzM36Ju9LU=;
  b=WafDt1XYe8pVkOJ/b6kDTnJ30GblIJHHxi9V4eSDAyBosW8YpFzYlMlp
   GrKb+oioJcD6ShDwMVlnoYjLXgCJOJ0E4PntVdXtsK1fIMp7RQwvNyaeB
   8u8ZzNCz2IGSS0sfm6BonKELAqmVb/4UoHGy9UnNcvRkHmULYgvR+0WHu
   P/S4CaHE54MUjegJ7lVUpKpm79IFOfgyA1dv3UrszU39Ys8OXnb7SMYqO
   VXnunORbBQT1RESUpBMx2b5oNC3Poe88iusx265eQbRFVkFX6D5WvYRdu
   C6DcI2Hf9+Vc+iO+/oVUkB/FvBJfR9YRqX2jCNyVBKfwEdlWIe8atAwLi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="448252642"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="448252642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 20:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="869071563"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="869071563"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 20:24:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:24:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:24:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 20:24:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 20:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtK4E9bd24B/hxRTUUQH/wd90Q+Q4JVgeQ/SDAD6Q4yWyH+ZXosk9e8WxfSPF4zW6/U4KmrqB+/KX2+rkDuOy/PC0mXlFr7r/bPYesjgQe+x3YDl1m+3gKu5rvFdH8Kid1gJHf3U+UYYIW2daRNPRnnYFjg5Pvsbi2gD/VU512hQG/f3cK5koOjz33XRxwYetcyhYuJlvXWePNbaYjeqiJToiuZPwa14Ba2b3Ai/9yoh2CYDVLM3lPB2bcwiCzlW07HHi9f1Dd76tGnw5iHjzX7fdy91CEggGzQeLP9TucUc1DUlqC29F2PH0CS7P/T9ZRtbJvy/2+d28Ilj0nb8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA6VNWMHLdwLwKBAv8gd3PRYQOY1POAZ5bSLiVI/sFQ=;
 b=a+lNmnrpn1lv16vPEtNwm3RGMN8evkixElenvTHPNnAUJ4ve6ld852OatD6c9mq5YsGIQFJY7vS7b7+8uclidEkIuZB+BQsoQmUSjnV7qbz2Kp/aEZi/+KCZIJNg9gkwQfXfiVYTO+6tbTFypZSAAQEbfAd/sDgz46Lvkq5skil66hHESa6UbJudU7BAz0mKkA1zv3gsLAbckwSMOfpGVekhMS6UbmQWzUOVoVmw1WC6ambfajJu/M5LyMwLWzCPucKWcq9kBoVHSJyWz1j+Z+g9VPetKJyiOgLvE5CxjDm6UHU1aOd71s9xNV1Wj0ePeLDA/f41HHb6a12qf/C1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 03:24:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 03:24:28 +0000
Date: Sun, 8 Oct 2023 20:24:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] tools/testing/cxl: Make cxl_memdev_state
 available to other command emulation
Message-ID: <65237268d5e97_1d9884294be@iweiny-mobl.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657721157.1491153.10282227094664408585.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169657721157.1491153.10282227094664408585.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:a03:54::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f6bffd-5d96-451b-6055-08dbc8773e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWK4kmGMLNqcXQcEsM/X4B8jCY7uWB0OFyC5NTlpemhteM7ALfZd6KrPX+3vbF3aGi5Szu+nDfnUbTnXNYDK1SLmn7hvHzRNcokOmdqPjavcFa67iPKbSP5j0KL2mYKWpL/2AHTeOylZGOUqjjOrDRtMih+Q3pGYHpBi1gEBybueRpWNIrtaQXDT/4Seyr9aArG3p7SQmQwaMfnFP430v2QQrGtxESj+ZxUijVw+yCaVsSBewuY8VMEk76ak/vi+Iy9/J4bIrByj6AWkWpy8TC1t4lL6ZWgWY+laTVfZBgEOMNxluWSQdRmX+AVyqymH/AoTgMqG4baVbm7zv5aywnQ3IWUSVR6XzZxFgjWy1jyFheo7jNBcUD45BABWLRvq9hZt4EZnObphbH7K7ktuLsWIWB2aHihdeXNrfM2e+AzyZ6dYk83jr9t3LSsFGcvcThyYaUYAY4vjJhXz2CFj0a9EJ3FPkLnEGn5SdGsPuw68gUPSq5bKIdE+IbOfiPmJNgGpEnfjOJ5QLHOg9LQ9PL82kdEWS3/PQUHYbEYhhrR7P+qtRezveLC26ujJfN1K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(478600001)(4744005)(6666004)(6506007)(6512007)(8676002)(2906002)(66556008)(66946007)(66476007)(6486002)(44832011)(5660300002)(316002)(41300700001)(8936002)(82960400001)(38100700002)(86362001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dvowUsKZPTvorPzfW3ktL1W2ai7o5Y7rxS6rSTAJH5jbgbll5UtyWl7EzUmQ?=
 =?us-ascii?Q?gt/ODC5lEurNGV3KqWiHyI7VTdSJ68wepVnZshVAeQZsQ0FXuGyDhOlN9HzO?=
 =?us-ascii?Q?x9ErJy+662mJK03g/OE+MoFDIkiu11rZJu24H6BORF8Zf8iHP90l8PqXaupE?=
 =?us-ascii?Q?ttuIeB4Wopv1Oj0IWdtiLYXMN3nnV3s7cGEOleuIFfQeGCkVx90F29QfwFBR?=
 =?us-ascii?Q?OnMIOVT4AbUe4V+dD2BjEn3p91pWl0HFGdRh4yWBvBdR7aaWyHZEa9Nmmaij?=
 =?us-ascii?Q?sp0BxrOz6ClOve6q4//OGJ344FQ3DHh37aIEvBHM+6NsUIrc6U/qBwbi367a?=
 =?us-ascii?Q?4dPSWQZb8iyhb7qojmpdBgubAoO+qnHo8AIRRs63OckC9Lm3j+pVWRvpZn2Z?=
 =?us-ascii?Q?gnJxing3MChuLwjPzpw2TfBJ1KYj21UETwl5vYfv3ME3KUX9Wxq1nq1zf7rI?=
 =?us-ascii?Q?FM6dtiyR9gxnNDHGOEZ3ns3/CzeJiuAQlE98pQCAFF+Z2mRsi9SaOq5iuLOD?=
 =?us-ascii?Q?LT229UimZBpH4ArgiZLcE/aNoKmu6q91dIw1v+VEv/t+EjscjPWMNrbPTeeI?=
 =?us-ascii?Q?5lcWrdh70EpbdWZQyq9OZ2Fda+iyavJ/IYYXSoDp7tK6Nnx7uiSbGarp0jQK?=
 =?us-ascii?Q?QoOwdPz+nwcozXGjgNdyQSXyBkzxPxttAZWzEGWKkl81ZrNnACPzUoyCKRmx?=
 =?us-ascii?Q?f90+PsM6qdT9W06w4XasvQZbbPfrFBZ4cPjca7cA+ohIiZIcQZWjLIeoNFb7?=
 =?us-ascii?Q?W7GbV3VzDLTOHeX9+qidnv0k0BpJ/TxoWRV3aoseNNfa5+VwvQpTW6CjfQ6o?=
 =?us-ascii?Q?DwI7yNdPa15vX6ELAuU+mPClTEL9B182XaMemr5WdmgCom7wMWFz36yzpdAI?=
 =?us-ascii?Q?JVPdGuQEpQZVqQhdlTmf4KMxuXVwZHzXx/qDYB7CBwnIhVJaTT3uuwwH+yUR?=
 =?us-ascii?Q?qIMP+FVbwMvk2Sa8i1a+fSAp3se7Pf1gfWIQk2QrjnP6ZReofMBYlbhKjsvY?=
 =?us-ascii?Q?osbsgg47neKgxu4y8oK7QSv0ei8+rucFF5iG8WhwWYaxYPZgUZxbv0z6lGMQ?=
 =?us-ascii?Q?I7ScLKz+eNKOOchLNxSHMUEbE8X2PNMNkgTYt2xUkrRbgk9HWkL3xvmqq9vb?=
 =?us-ascii?Q?N6Zlrf0PaU8Nfqk3tMwbXrzaJIB2fSEktfOwFaO1w5GhnVddEsReoAb9KFoF?=
 =?us-ascii?Q?G+Mrmw7WNqAi1lQd/RF8+TbEv0xAsEyhKljCHriO52XRtQJchDR621Cp9r/n?=
 =?us-ascii?Q?OpetnawgAv/nVhfSn7VK2WHI4z6HIiq0Wuc0zgcsv8EOXygD8pjBXTRzMFE5?=
 =?us-ascii?Q?L2vTHUONg2B30eG6Q9BHZ908MmU2j3wAL6x+Wrq9wEUhzHFjjXqdjQdXeaT/?=
 =?us-ascii?Q?lDSRdNdUp7VwIivZroieFgMm2mLYyTB7Pj0g7PoES2WiaeayR5smQ6e4ptpN?=
 =?us-ascii?Q?rmj0pO2Vkpv/gESZ08HXTBuSV/bQOfF4NwMr0ZrRC+E9z2FcUSYVsQMveODr?=
 =?us-ascii?Q?vwKuGqNe18WeCI1temTJWVgUNQNLfgK0fsd95ftPe9FWRi1R8PDVK8KRs/d7?=
 =?us-ascii?Q?3wV6TrbLlRfY918kHVB7EXSJcqb3Ln6AeLdPrFzZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f6bffd-5d96-451b-6055-08dbc8773e89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 03:24:28.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhu+1ltNWPYvC1hkc8th8VKn44aMNrtBeKiaQcyAQUoLmt7n8bBtqG9LuDmzCZqyXPxVxOs73sh8Yfe5ErklCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_MED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> Move @mds out of the event specific 'struct mock_event_store' and into
> the base 'struct cxl_mockmem_data' directly. This is in preparation for
> enabling cxl_test to exercise the notifier flow for 'sanitize' operation
> completion.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
