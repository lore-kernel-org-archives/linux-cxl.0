Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA39C19F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHAVdM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiHAVdL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 17:33:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D235140FC
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659389590; x=1690925590;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KK8ew5v/dvixkeUN8us1SN3IkFtRzH3AiLwG5lMV9pk=;
  b=aGyVFXrJuQUfIAAnZJRpgUBmKus+oM+y1VzuMiq1p5q6VRA0M5f/aYlG
   fPSQQ8vhjGl8cFAKGsUIN/MHL8dON3AjT0CMJWa/C5cvg/djaw5zq4P3/
   eJI2gcKkYkXQ1xpbC/Dg+wKXdNVMyrzSx54MFxf08Y7DsBTi0RupFI2zy
   FwNUOYGkAy3t3ShSwn/Ty9TsBybRbNI1YhNTFIXt96MAES2a1iOQpHj7W
   A69uDsoDO9IamMF55joUS0QvULwIMXjyb2hqj1zAwOPkL6W5TH5jgPvhL
   9/3eX3/xTMWWFctYPA7CinTVw7+fQmeBFhHSGS5+TY1LoiSw2d4EtI5OA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290468600"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="290468600"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 14:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="630420526"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2022 14:32:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 14:32:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 14:32:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 14:32:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 14:32:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNMlMrg36mgc0VurpWq/Yx1JOf+i93rsZx6pQmMKUrS92fMKhzkITzgZVBRpONyUbWS1GammsjyOtWCsaJvB1dUAFuW35G94v6QbuDG95WgzgWgp21EWzyw5svBYHBs+f6HifMQPYo0vR1A1ydn8KGi8H/WxcjzXqKqXIMaqUUuQaFUkAbRDuwuJKO1TyL3qakXIwVv+ynyge9l7fGli3AO8nGErQr70bNDWe3W6g1jNlO6eTVceyz1JzBWp6Ajs1u5co293QT5aQsEU8RjfAbaGDJaeKehI8rNx4OHq9CKNsPamsBuH69Im4xCbjm4/Y59tOvmqS9u1QZ9+33uJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heIuscgMny/S1KXYMSRZapGNI+zrBLOzgjo+N9tgT+s=;
 b=lPAHjIiJz+lZuHuBrhB7lUzEJrlbtvHphHxZr7/vEi3a1vkl4QHtPp+VTc6pw5zlPLxF4eyce2/hge6EIlh1LI8m4dHFDHC3mw+Nx8mx3E7Sk3a97lhlHy0GAKAZIjWV9uUXIElsebEsNbP+sMKka3XhUYzB1CxVOVcED7RhuNTOYN0NtmWgkprZMfrV3RHKJNVdSEnPy6MO/UA1JA+SXZbpqCljHRiMPxwOZIygUDDCEiKlF6IrQNmGXBo2phZZ3ZPZpBJ+S5CN+yq4ff6GqXKH5ryG3bo6rlRf84wtlSt5QwcHhShVNRMLHG1qoNRT27reKkEVSJ6Jw63TMr964A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4396.namprd11.prod.outlook.com
 (2603:10b6:5:203::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 21:32:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:32:55 +0000
Date:   Mon, 1 Aug 2022 14:32:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Message-ID: <62e8468593a60_3044029449@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
 <919eb8198e880205b81da7090d6f0535782f0fad.camel@intel.com>
 <d0c2044b096d8a79c98501a5178cc9b7dca422ea.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0c2044b096d8a79c98501a5178cc9b7dca422ea.camel@intel.com>
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250d6987-63f0-440d-2412-08da74056597
X-MS-TrafficTypeDiagnostic: DM6PR11MB4396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TZ2Tp0BqcAWxARm+x9Z3fRraWPOKS82UKnsWJCOua+FAKo2+7TuboCW9qCNwCFMoDPRCWsLXqIqPyyDgvBs2W19/SZkwjzpuwu4UA4gkBybszTz7haCh/CLwCYIs6Y3bKWPZOXC53ygw2ylNbi45aWa419n+g89lJOU+iIUePcC4eisy/oW+VMyOHFHosY2xcx7q9Z++6efo4fBBVryXvhmhLmMS6zuX/zMi//OL5URaCSNjHjC9HtJZO/LqdaRXJxZ2eKNmeSFKNczwSxAc/BD/WTYM9AHrs8xU3JjiKJSafI35BUbj0xjKEePRIYHvLqoRQhN4MPi49liN+fOySVcpGWUHUMG5zbo21Ru7wcvJXEVKG4j9kEQP5AhTSfNuTiKZ7HssGXJ/n+hg4Ln+RPGYseh+XG2cQWKdXHjmB0tpJhF5zX/i/iJjdq7Q4j03c9dASxcYwBcTk4MhKX7Q8GjFNo37/0MIAH1HJxYLkFVdj2MchnXTdQ5LojNyFwJOf1Dz3EfemANtS0hCzpID9GP6A0xvCHAh3rHzEVFoeQ1tGEmx10xP6mYXaH2eqlbbIp8VSMFnCRB2CGTVOl7xNz1NgjmjFrVIX+wyphJSQG1WxnwHHKwGcDYYsmPwSSl/aUNDwW0Z7fHkCRaIdim651U3QjKUhCPVA2qJGqSXLTSKrHI1hsLqe/9ZBYpMEJUkRy7i9wweYrNAWf080yBxsx26DPo0m5/QV75nWO6r9zDdoCsxfSB/kv9KuyY0sy8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(346002)(376002)(82960400001)(316002)(110136005)(38100700002)(9686003)(26005)(41300700001)(66556008)(6486002)(83380400001)(66476007)(66946007)(6512007)(478600001)(186003)(6506007)(5660300002)(8936002)(2906002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qWDB6ijJh1qAXkl+NQY0OkbsMaqhs4jVckwe3bWZYv/KWfW8chBF42UqPe?=
 =?iso-8859-1?Q?8oPeKdXdTOAEygO8hjisMu5GhhT4kxTlwZj1wnxtxpLavsVBrUeh+Q3CXj?=
 =?iso-8859-1?Q?+IXfhN1ljprwpf1Fu7lfqPAzx7KKCxQqQ/npqgvnXhgZz/Jc4h3FHZkKNA?=
 =?iso-8859-1?Q?TyE+62/V9XzUwHmE1JkQmxz2DjExD8kKl/zDcnRLNYjygutnK94q8YtY4H?=
 =?iso-8859-1?Q?J0A516RckDaLIBlXCErn1Jpb8+nIDMV7feSIr4VOTD6Ctdx/o1URrnEZCd?=
 =?iso-8859-1?Q?yeN5Z9vfX1/q5cxMlMxii8z1DVJwy5ZMcM8jV3yEZmsOI7wB/sN/hWebOs?=
 =?iso-8859-1?Q?IRS1ukQzP9I5ji4BqnIDNKKG6hg5cvMv5EDk3+hzqiIV1IVrKdCYJvS1Hn?=
 =?iso-8859-1?Q?LFDbhmq3HSvH/n9BzFKZyYymuuI6x2XchQiSLdyBlA75siCYZ4/J2LjGIz?=
 =?iso-8859-1?Q?rzU+p1RePXjXJvGQ2s9JyakJQIOq0jZeU6ZObM/wNbgJ8GQGDXHljw8Db0?=
 =?iso-8859-1?Q?XsfJr6y05gSPJwyaPJZnnEy9UxDYo/rsJipnzDsoFhaZ7id2DN/Hb+hr0c?=
 =?iso-8859-1?Q?drG51n2oD2iLJ+1SOBqiVIvVxb1cGgiEw8+5jm106ZBgi0ZC08D/VOmnTT?=
 =?iso-8859-1?Q?5WMN7idF3cKAAvna7CbG2s8dRcrG9w/VvfsATxIQPPJ4D3P5wR6HfjwHfL?=
 =?iso-8859-1?Q?g+guWrSQy4W3iA16gnYDOPwMEGk39EXJDf7Jxw7fCwus6W269IRSBC5Q9f?=
 =?iso-8859-1?Q?081RfPXJyT8ii6ULft9QtiU3aXWU9ubtkwJcJTxwSEMBKy5qirbMP8Pbq7?=
 =?iso-8859-1?Q?n5FHJ7C3lI9el9TeLqCyuhfJs46Tewd/8vCtkyv8pfVTEsfxuRBKe8MeQ4?=
 =?iso-8859-1?Q?WF/EPq772xlvLdfrh2nZQEY7h1dFsB0N8+BLySZx2hq4zJjqyR8aQPyEjo?=
 =?iso-8859-1?Q?6kaJnddsZUCyPX9ViyQyw3cF/iIS23lvqTvwIYU/sfxBtdOlkLVbuKmE6t?=
 =?iso-8859-1?Q?gdtvCUAc83P3p/1yLChU96xi9vXtm9j07NuKSyrUKQio90SKmU+ResuhxY?=
 =?iso-8859-1?Q?hT5UPThnT3TI1GdzwCU83eTMyL7BtkCK9NLiNh8zcopuQkwIwRxugn/WgG?=
 =?iso-8859-1?Q?777XjqIhSwxAiTRFb6JbY5b+l75bSo2qAkmlibufycGstggK9gzU2vfjM1?=
 =?iso-8859-1?Q?dtt6dSDQECCFsUn4hFj+tB5XqoPhstcaJi5hPCBJkuLwQ75oxVaPy1l1tO?=
 =?iso-8859-1?Q?R4BCLix0nvwN+5TIoNSNTVd3APAEdzn8Yl6kn3iEdis5ATZ5Z7Wz5BmGT7?=
 =?iso-8859-1?Q?8NLMaFE5FCxwD+wOWa5U0ujtFigIv4i79vXTcZN78wRxg/8wKT66mx2cy9?=
 =?iso-8859-1?Q?P/uR416sdIqi6GRNEuqBRFyhS6ptrOXSqKa5bagzC36/2j0IrTOqAzp8cK?=
 =?iso-8859-1?Q?iRJXa0EOVqs929nVitiJ0/67/td9w9OynlaPWHQZaSbg1q0znMfGZ/6aqY?=
 =?iso-8859-1?Q?xdfD/xy9jP8sTKzM3yh6bd0XdzLmeMxBDRTZ/5MEiayvbsKksvQ4G8RXTX?=
 =?iso-8859-1?Q?hzwWSegWaqIGsYzcBRs2Z+Boukyt/Mrctl/kC09zxtIEEUEkHhqSdr3lBw?=
 =?iso-8859-1?Q?UWa2SuRLOj87VOZQ2R18oOiM3ja4tYgsGxZHSuywAom/dUHJqsoep3yw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 250d6987-63f0-440d-2412-08da74056597
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:32:55.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29tqWAXfsUoqQS3lkMWlDrqqOneXwYfJQJN8BOLGEg/JIv/PLn5aAG/KzOJjBq3qtf5aSfJe6ZDZoKtOOl6k1fHwwBlFXdok0v6C16ccuMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4396
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Verma, Vishal L wrote:
> On Mon, 2022-08-01 at 19:38 +0000, Verma, Vishal L wrote:
> > On Fri, 2022-07-22 at 17:56 -0700, Dan Williams wrote:
> > > For switch and endpoint decoders the relationship of decoders to
> > > regions
> > > is 1:1. However, for root decoders the relationship is 1:N. Also,
> > > regions are already children of root decoders, so the 1:N
> > > relationship
> > > is observed by walking the following glob:
> > > 
> > >     /sys/bus/cxl/devices/$decoder/region*
> > > 
> > > Hide the vestigial 'region' attribute for root decoders.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/core/port.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 3d2d0119cc3d..bffde862de0b 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -290,7 +290,6 @@ static struct attribute *cxl_decoder_base_attrs[]
> > > = {
> > >         &dev_attr_locked.attr,
> > >         &dev_attr_interleave_granularity.attr,
> > >         &dev_attr_interleave_ways.attr,
> > > -       SET_CXL_REGION_ATTR(region)
> > >         NULL,
> > >  };
> > >  
> > > @@ -345,6 +344,7 @@ static const struct attribute_group
> > > *cxl_decoder_root_attribute_groups[] = {
> > >  static struct attribute *cxl_decoder_switch_attrs[] = {
> > >         &dev_attr_target_type.attr,
> > >         &dev_attr_target_list.attr,
> > > +       SET_CXL_REGION_ATTR(region)
> > 
> > This patch removes the 'region' attr from switch decoders, but isn't it
> > also vestigial under root decoders?
> 
> Oh, never mind, I misread the patch - it adds it to switch and endpoint
> decoders, removes from root.

Oh, and never mind my previous comment too.

> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks!
