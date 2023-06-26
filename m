Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BCEB64D7
	for <linux-cxl@archiver.kernel.org>; Mon, 26 Jun 2023 22:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjFZWro (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 26 Jun 2023 18:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjFZWrn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 26 Jun 2023 18:47:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7172BD
        for <linux-cxl@vger.kernel.org>; Mon, 26 Jun 2023 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687819662; x=1719355662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7SfEiswHhf1Fanah4VKJkdl/2SeJ1du08MNn26e+6BQ=;
  b=YUNEc6gAlilItt9OzeWYSpcQZdUZzOCWIBeCyo4re79ZGJkmR9C6PHou
   AdnAIvna9I/q4tCH1J03s7rH7Oti5d8LH8nkltQx6gYSH/j8t4XMDbwto
   YY6Zqc/WmVvAFcsUcFFCGis+K0XwolJ+cS1gqITCIAuPLQBUGcA92GWbl
   pM2uPAtBfs1c3cTeLSdJ4ITlDaUaedZZovFfKAjNJOcg0Pz1fnnNQ2zm2
   GClArCwX6LSAuVTuckZ77U3sKHYVD2mq7YXYPDP44Exd4y9+0kpEw3oww
   pMNplLnCNOpppcXEb9xOvVDLh4SA9a2kLuDs2xkhJGkuv6+EPJY62RKSq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340996681"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340996681"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 15:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719545853"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="719545853"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 15:47:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 15:47:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 15:47:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 15:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd4vjAouMeXSoCNUF1qo+AnIvU7WhiJULpQbBZ8iTATuUHp5+TPTNJsvXwBebvT4+dQAKrh5moBO1jv6G/ZOfeN4Qr9f7/rKeNq2xMu5cE1YMw2zddHagqDeNufP9yubYRZUFVaJKTDGRbZJANYt3LNSuqCcrYSLLG6bf8uOR4cbdzc5ARtKXv4tHe7NXaFFdGCnWWre6C/9zz1R7IwVLjttY5lfAUvy2npSRuyJynW8KfSCh7ScRnRH3EoJJ2p1WbjyPUADg9G/GxnswQiL/V6brBhWNtde59mxmob5OxSBibrvOy/AOCdA1KW4bk+jraTIKWo2YyjWNwuBL/fAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBOMTcJvPKKtX2Hw9m42vLXjOcU/0sezwU4bf6jd80E=;
 b=hm9uN+X4bSTpbabZ83/46AK9VGfpXSAElb69FZgLVcAPbWjjRkoX6lr/ycUrc/ZDujW3uZQ0TNQjFfC9Ur+4SDx6wARX5s6ao3/hF7bTGaPvhD0bebHqj45IGVLuZejmcsVN8yT3SaRq11IbMPcFK8zSX2Yg7GtGISHI5SKlJfXOHmIJwD5sfYYas7e+3mmWFU8Ya9lx12PBiSp87zlzDUvd/RLhs/QROz+U9cL0U6RQo8jzvqT/tx2qkcpsbzwzeIlqdnQTVar8Ld19ma5iucaoUJ+sVhHNhLch1xedTWBH1ZPcP/kHJMq6DyXLxU2j16b3k1ALM/UQIZ0n2cofcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 22:47:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Mon, 26 Jun 2023
 22:47:34 +0000
Date:   Mon, 26 Jun 2023 15:47:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 0/7] cxl: Support device sanitation
Message-ID: <649a1583f3331_8e178294f6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <6498c35a934ab_8e178294b9@dwillia2-xfh.jf.intel.com.notmuch>
 <ll3imaqzzqkhmsa2r4rxxzhmgnpoayuasb3ay5dfx47f7avco2@j6bmlcelamco>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ll3imaqzzqkhmsa2r4rxxzhmgnpoayuasb3ay5dfx47f7avco2@j6bmlcelamco>
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f54738-985a-4bc4-b0c3-08db76975514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ad6KHBWaeRolCbttWGOGPpvaawnmmpDgZXFD3SA6pyPXyChHgMqjlxmw79MUjRykcsE8DSAWx2ObUWfEnhAhOqBTB6nbY+E6+iRL8g3PNB+C+X3D+z5tILuT8JlHq5H4NABSJmbilA39CXbt5OHCRLds0wH6j3pETznX4mZ9yETtYiCgElWqRFI0NLJ3P76AHfVithnr7HsCWmc1Jx76n5lo6VNvgeN/djPBRWtp9h4KY+gZYXj5ZBjh54GvOc2ui6J0uB+7p3IuOqhyIgxxMHY/bwMsZITDOMK+4ckiAcwY/zZq3kudtKj4DFuLJ6/qutssGyTLJGj/EpfULycnroFvDbu/hTauclbb6bEGs7rMcPh5NPzqcYC9xOeXOoTNDROGQixu+HtfhrqSEQ4uU3KtMT6pomx4VZhXutoQG+J6KQAHIgSQnFB0f6a5oeIFaRhtiHM1kYmuqxLTaMRh89QjAVa6chsjYGimXABkJ1rVsIm+eqedUDccTJHjU1+USQKbUYNnuZN5eqwWwj9NUdpRBlodFHeoiHQqsk4KuBuAQBdie1ljNgWfpryTsPw5CCoyYDhIXs8uri2mxCsRdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(2906002)(4744005)(9686003)(6486002)(38100700002)(82960400001)(83380400001)(6512007)(6506007)(186003)(26005)(966005)(41300700001)(86362001)(110136005)(478600001)(66556008)(66476007)(316002)(66946007)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3bFI2rmOkcZuogpCs0r/Z+DLbglCVOJbXBW9HR5ovjFrFeXG3lUmU0geDpj9?=
 =?us-ascii?Q?nDID1A3JvSzPXafhC4+FT7Ssl44XdfnQhRzgNw0sO2Bn9uWSTvoFwPNm9ZKz?=
 =?us-ascii?Q?AZ66Wpfw1NtdqIkdKjRQKo9CfzoFheyk4Qcn3FW3MAiTiuMdk2najrXjyay3?=
 =?us-ascii?Q?9NIsozr/YQ1L/Hojk3xWypKkNOtBIbTVe6sBmtGRFlaPO+33PWgE0TIs6pzT?=
 =?us-ascii?Q?BSywhMagdKvUDK+KbknSh3bI1Yx0ASedsdmfGcqH8Ef+ZSca7xe6KKJ0BV+C?=
 =?us-ascii?Q?fnPNU5JpZEOhEI1Y54l9pTH3Gz3b0jGS0bhy+AcTKiIqxd2dG41daTrTDnDg?=
 =?us-ascii?Q?5K+bjHh4BccIYGcmXmxJAk/3+R43Ziu4iMW9jelQMLOCMRXtZQvQokEt6MPz?=
 =?us-ascii?Q?8EaCm6DFPTK5v0peiKQlcB4bZ6oHxGwbBoCnphbRcxOjyobJgDxrBvqnguXB?=
 =?us-ascii?Q?M3VKvYSJvRvNqes1P8dpGoDNd09PrB03LztNOyK/RG5WulUdSFf79v73xU5i?=
 =?us-ascii?Q?QFWe22h8IIvqHGA/2wzIP/ByRlYPziMLAh5sQEY+mK6TYHxaljXpm7rmsSwb?=
 =?us-ascii?Q?b1w8WBAed3+DL1h+O16mZgEcuivBp07dyeTELcpACB/sTlkVnucVKa6ocP+S?=
 =?us-ascii?Q?K4AJRLraAfGzBBkP2KEzpmprUvw5MtQuZgEHR2BwTU30IFtkwNJdRMzKGVrY?=
 =?us-ascii?Q?2UR4eO0NzxN1fXFRw8DbRRQ7LhjK2hGb4AVRp1NajvkJaJbJeWzw41x/2Qno?=
 =?us-ascii?Q?6FMJxdw2T6N5R9VVV+A7JmBpls1fRVcYodN4KcKGnPHMV0q9KcO1g0Qn9rOY?=
 =?us-ascii?Q?g3yBxUcccSZYB+DktxZ5M/C/BIPlPY6Db/7IBHwKhn2+DfJfJ+m38S1Rqjit?=
 =?us-ascii?Q?CkJ5NRokl3HCXiKr/mKihb7J+r/hK2Qroenew4GvrYVFF4BT1mWeeXYmjqi0?=
 =?us-ascii?Q?4n5nnnB8+MhQyd0aPg5i9YXlb4G+yGC4se71QM7wSv3gT+i3mddIPTvg8KDY?=
 =?us-ascii?Q?NLGsk55FM+pq2EDv+Uq9BPq3QE2Lqz4NF5IEde96yNuH9RhMib7L1o31Q0fM?=
 =?us-ascii?Q?UoBR6WnDnqXSQs1+Sx8BLXJsSgmZsRIbWZPJYqv+zwNPgTrKbtMURAYm2/nH?=
 =?us-ascii?Q?0+SqJvr3vXYwVC67GvdFhc4gr7xs66n/JHmD8ugbwO75gvJasQDKiNP0S/V/?=
 =?us-ascii?Q?NlaH6jGtrnMupSYDa0go9zM8K6lp8slY61w4teIhddehJbMkX3BwTwmiV84x?=
 =?us-ascii?Q?FzUwR9vJ7BTZ+PhTKLJGucIPyun8hBlWtNk8gjn+CDtIHqWRI+Q8WnfoS4I/?=
 =?us-ascii?Q?PWc+Lw0/uQ1/tDMwBui2n147o5+wD3zAhA7AfPGvHidzPeXrSYjJg/wYm9Sd?=
 =?us-ascii?Q?B1fEcIti8KtGnLnEXvngEm9Zjt2r/YExk4zpXZAmAKnoP8KT+pthDZFM7LtJ?=
 =?us-ascii?Q?7OltWWLS9/UnBPcrI234zY9iF3MbFXX5aJ1jAMhak/tUP/5VXY/oWiNwzr9o?=
 =?us-ascii?Q?q5hluy0//JohhUrNkECTR8rRSPO0YsAHFZViokPlh9Hainad0lAQ2D18QaNM?=
 =?us-ascii?Q?llvoQqid9tqDH4kIo8jlc4q9Gi9U/M/eqvnqwKd3VjxKmhQrqpXGnQxs/j3H?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f54738-985a-4bc4-b0c3-08db76975514
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 22:47:34.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nje+WGEwY2Jwm7shwiXOhi+CW6ux57mmLh7aJgoD7XNKmAxncFSXfiT2/GcK4J41Hnt63f04rZXEfPVjSumh2KX6P3M+JHCMF0tLlEmlXB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Sun, 25 Jun 2023, Dan Williams wrote:
> 
> >This looks good to me after s/([sS])anitation/\1anitization/ throughout
> >and some othe minor fixups that I mentioned.
> >
> >Merged for v6.5.
> 
> fyi per https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=pending&id=0c36b6ad436a38b167af16e6c690c890b8b2df62
> this seems to be missing this fix:
> 
> https://lore.kernel.org/linux-cxl/ispowzuk5fg2u7zbpenocvyihh4t3kywtszcbg245unypzduex@jenknfy62rjl/

Oh, I missed that. Can you send it as a follow-on? Also make sure you
have "core.abbrev = 12" in your git config if you include a Fixes: tag.
