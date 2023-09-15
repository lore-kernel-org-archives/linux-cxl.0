Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70675C46CA1
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Sep 2023 22:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbjIOWvK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Sep 2023 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjIOWul (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Sep 2023 18:50:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0DF271C
        for <linux-cxl@vger.kernel.org>; Fri, 15 Sep 2023 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694818186; x=1726354186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HJFrFct1Sdtd/enNynKkDVorAK8vUu14+TFrBhxsYw=;
  b=We484Fq+bcwASrQiFN421g1dFA1Ru/XOmSL+Rek7X1GNW2LV+FoKqxNA
   r+mMlm0aGhJKI3w5MvU2DLxytjMiYHQSW9cDj5Z5WPN8h8b/iZnSBZSjD
   pUhbJ1FuGAKwiXXY14g5qmLTTwr+7AM/+Y5bJ8H4DsuvnDtNEtPyKmVY3
   wCmc11ToqZyhgJzjdvk4ckhigGTTp8D9rqNggnOjFulRZl/A3Q03Khsi5
   mrjSmUyVVW+baOaEZGFnOjuk6L+/rELU8IoS9RS7u+KiU/JLS4ebBQBkj
   q3t6igujIwevqcyX6gvYwFWRYO6gcLWWiCzJUsOLa/IG4kQ/LZLHv3ohs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383192262"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="383192262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 15:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="721843837"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="721843837"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 15:49:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 15:49:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 15:49:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 15:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaXzBzIz493t8ZK9oCHhaQMS8WPAlsvOWkS9BI5cqvxi56sI/99ro2Vcg/kQK+BHHeoju2rqvedkZ8CvVTK7NmRIEoxK1eRHIYL55+5dAAqpcWMUIDPMmfDadmEiFGKfGLigrFR8dDjn0ragNmzrGcnZJ7DhFdLGhbHuWGh815e9mvi43SMK/efrOWazTO0GvczTqV1pR8E0D8pl3llUBCuOtL91HiBzCuaEkr9c0EADlCcbWA0kKZaae+Wtxzg4QAJ9efNXvmfA/K+aabHPJrLzmxa4olz+dM8jYhpl1z2w9hpd4fZ6vu7Q9kh3SwmyZfSTXvphgwlncWTp4T7cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I6OssLjAJbO5FoGyVrJpBqozTCA+ERIkFBOGTi8UUQ=;
 b=TtYNUr2Bw//WlGlBLrrzBLXL6vXplNANi2ciMv4OG4q1ObtC6c6ITgXNnnZkijOJT4hqKcbcbMwCRtdUIhwzutzzoCbzzXO8Ym7em8K01T7cYl2ka/JJMfInG4mOFIFYp3zrsiQcKDcgUt+xkTnu/YC85fISlR0Ovz7aFKzB1Guh+6cQ9pNGn+db5TGWDjq9piB5215V5EoWLu6iI2x0RBZM9l4qNCp9HQGAx5hUfcR406HC4m4xXiLpGMicqnyDKEiCtEfP1rRaq2OBJq1Y6xY0bTm75C48SsPp1HoEQxa+ZRbYDqwBq0P3OvAJDJ4Bfuz/eh96rXw7wcMJe+DqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7710.namprd11.prod.outlook.com (2603:10b6:510:298::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 22:49:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 22:49:36 +0000
Message-ID: <1b66b8ae-143d-b227-27de-988ee9f0ce04@intel.com>
Date:   Fri, 15 Sep 2023 15:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 1/2] cxl: Move command enumeration from dev_dbg() to
 traceevent
To:     Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dan.j.williams@intel.com>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
 <6504d69a10453_37d9bb294a1@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6504d69a10453_37d9bb294a1@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1f8a85-65c3-4643-72a8-08dbb63e08e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKy1UKm35KyzBtrFVasrXWduCB3X39s/HxMGE4iG2eqjP5B3QC8btrcrazd/UOrQVvX/puh3gsJI+RPTXDc97wcSdroJtWfhlOarDxR/PmotKyx8teX4k2KlbmsdyNI5ZXCDtfN8m79FkKS01tkJGPFio32M/bKfeiBcSwM/pWGzmQ2QmW6DQ+ypO7Q5YDj2ZoxNYW6sVCNPQaplP+mamJSMnMca5aZ1zlx9eEknt9R3qlbOQuo6QdY+p98iw7VVHIb+ef9J/NNw0LdjSv63rUyRwvfV2/orj7Kqsgi2bWfBBarEduETDgwPxNUkIokoaruPKuw1CsBZp37SEo8eNFQdshdJ5lNANb9EXGaTeHGx6nxmu2EwWz7effdtdVlJe4HBRYryDylXH2Xu4UKOwgBSnNVeqeNjiZ0ArWvq3dUmqk++OtAVjzo4T2tDdNqwHXN8Xo9JtYHV1979fkJVU4iwQxVP6NfwFBIrr20SF6fcgX2TuGHo5YjEpd90T0ZRWNV81wiLdW7AIuOwW8rcV5cd2mEM4XYKmEgsuUxJ2rS9kTGM2TAGzPeDCO/fsAAe5R5t3ceVKLe9ociEzDcKGFE6r39naYVkCun8ZKyJHpxzPeYBxk49Kxg52iV9f/wlXnJf0yHdia7ufdi7/60H3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(1800799009)(186009)(451199024)(4326008)(8936002)(6512007)(82960400001)(53546011)(6666004)(6486002)(6506007)(26005)(2906002)(2616005)(86362001)(316002)(44832011)(5660300002)(107886003)(31696002)(8676002)(41300700001)(66946007)(66476007)(36756003)(66556008)(38100700002)(966005)(478600001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZKVCtIRzhwZWJJZGovcVpQekY5MGY0YVZ6bElZZHdEWDEyYXY0b3JSSHR6?=
 =?utf-8?B?NTFSWmJvV2JOczVwelAwUzJnR2NDNXdCaEFlUDdCdEdWbzhCQlg0eWZ6SE5m?=
 =?utf-8?B?RkNtSW1OTk5xRktreHZxQWRtaWRUOVpVZyt5K0pvT0NZT3VScVRMU2E5Sk9H?=
 =?utf-8?B?SWE0ZHQ4Y2RxY1FnUndiUW1wZUNEaTNZenR6T0piMXQ1ckMvYm0rSzBEbEQ0?=
 =?utf-8?B?WmQrTjFPa0l0TCtBb2ZqY3dxRnB3WWwrVFBVbFVxRDdvZ0pwTUdUTFFSYms3?=
 =?utf-8?B?M3JkYTRDSE91eXdIdmZPVjVZQnN5dGg0QXYxYXVNOGdNL2pYUWlvd2Q1cFZx?=
 =?utf-8?B?ZThwTUtKeG1OUCtac1BXakRub2tHbGRWK255VHlZTXovY050VGJGMkU0N1B0?=
 =?utf-8?B?VUZYRHJFbFZlTTV0aXN1Nlh6UGt6MVN0WEtlb216aDZuU0JKUElVSllUVmFr?=
 =?utf-8?B?RFBkTlZKaXhabytKYkQ2Yy9WTW0xSk5EUVZWR2s1cVdMTzQweEhCQ3ZLMnlM?=
 =?utf-8?B?ODVwVnZtc1Y4c3pqRzdXTnMyN2pha0M3SVJBdXhtNnllRFBLeFlkQ21YNnRo?=
 =?utf-8?B?ZUh1bzBJaFlPSkhlcXdxS1BXVHRxM3ltWGFjeTh4bEJlNHZwNTNKRmg5eHBi?=
 =?utf-8?B?cGtXa3FmSlhlRmF3Qy9zQkFuaWViZUk3NXUvVXYzelF1TmZIdEJRdUxwUmh5?=
 =?utf-8?B?YlVQWkI2KzBTcnRxeGViUlhUd1c2OVJNZ0dmWVZoUFRMaW1PYmw3REQ2cGVX?=
 =?utf-8?B?TVFNbTkwbDVuSkFvN1lOcU5TNWxXNkg2M2JXa1JudCtkTnpTMTlPU3FGWXMx?=
 =?utf-8?B?Sy9RMENOcVpvbnEvQkRMZ0NiY2ozenRwTVBLd2F2WFoxZytiK1lZS3hJalVi?=
 =?utf-8?B?dHpyM095VDVlVGNXV2RZdnlxclNsc2p3blQzczh4VEdkdmZUalJQZVIrOHN6?=
 =?utf-8?B?WDZYRmd0Q3NwYzFzcnI2dDZNeWdKUUNqMHVkWGRvMnBWSU8rSGwwK0t2dHVP?=
 =?utf-8?B?UHIwMm5YZi9YUFYxL2IrU2RkaFRYZ2N4OGw5UUZQcUF3ejRScHFIekVNTEQz?=
 =?utf-8?B?dGRnUGpvZS8xWTZPZ3doRFJFdnZSTG1xNkRYUS8rS1ZHVXNFMnh1Q2ZVTlly?=
 =?utf-8?B?Y2hqVTF5V0VUN1YyTmRIeWkyZU01YzZhK1p4SlpSL0Zsck5oR1ZPT3VJNERj?=
 =?utf-8?B?UlM4S1JrWjZvZTRYU0UzamZySi82STczdlQ3d2FsenNub0w3TDVuc2JlRTl2?=
 =?utf-8?B?M2sxWm5tcWRidlJuVkJTck9xY3ZhaXJnaVM5Q25ENmtqQWU2YlNNWWxTMGpi?=
 =?utf-8?B?WFVJa1hMOXMwdjlRYmNQeURTcUlzeTN4TmtMMzg3QndJdmlpeEtmNHYxRHEv?=
 =?utf-8?B?VklHY1YvMGdNeW5tYjRzaXJnUmNJRERXYnVNUDJDYWcwTTc4bkUyN21Wditu?=
 =?utf-8?B?WGZ2eWNBVU4yZ0VHNG1vWi9FS1E3NHlIdHdzVExpM3FoVmxmYkRRSzJKbjll?=
 =?utf-8?B?NkxBbEFPWWhsZTVlMDJmMnNSUnlGRDBlTXlDUmsxaThhOEdQQjEyN3ZLcjRi?=
 =?utf-8?B?ZHYzdnFLMzUvUkNsNTlLQlZka1plK1U2T0hodW5oQXQyOENHWHhvbUdWZmZP?=
 =?utf-8?B?SlZoR3pSTjd4SExINFFZd0lvckVOM0ZMbFBhUStYZXluU3N2R2tyZTE4czV6?=
 =?utf-8?B?MEJ4MDlmSnQrbkdFM0t2Wlo5Z1hNdXVzS2pMYVErbm5jQ2JYL09EYTRHUUtC?=
 =?utf-8?B?Tks2MjVzRG9vZXM1T0I1Q1RXSDUwc2t6QVhTbE1KSjc1bFBNcVhNVjFaN0dD?=
 =?utf-8?B?TDhOSmNOWU9HMXAzcENReTB0amdSdFEyeTZzV1NTczhNdHB5ekZ1V1ZmVHNQ?=
 =?utf-8?B?OHhZUDRvUit3NmNIMnRaekQ0dmpuWkhYRFB3UWswMTBMclYvNXdNNzU1SVFU?=
 =?utf-8?B?UVZBOUJyVlVjazI2UUgxaG0xYUdxdjNRZG5BRmZEUFNhSG9RZFErbGNWTlBU?=
 =?utf-8?B?RTRiM08vWUxTT3FGSzdQcWNFSGhCSFVaRStoRUUyRHd1YUlSenpLcUJaUlh1?=
 =?utf-8?B?bExLTzhqazZkdkplT2JvSXlsV1VLYnNIUVVMWDZ1K1BlZ3NDWk95T0dWeXhT?=
 =?utf-8?Q?SuD0P9smYYjNxRf7WzdSZS0Xp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1f8a85-65c3-4643-72a8-08dbb63e08e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:49:35.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu3i1/YIAb3rF3sfsmiLOPnZpfruJVrVQLbYEMd0Dnj0dL1OtuzeSnbr8ePUVHM2rR4DwXmm4E/zZsbayoyXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7710
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/15/23 15:11, Ira Weiny wrote:
> Dave Jiang wrote:
>> Given that event logs outputs are all emitted to traceevent, move the
>> enumeration of log types to traceevent as well in order to keep all the
>> outputs at the same location.
>>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> My gut reaction was to nak this patch because I'm not sure how to enable
> trace events prior to module load.  Then I realized that this is in the
> cxl_core and is only triggered by driver loads.  So I've not tested this
> patch but I think the following sequence will work for these 2 patches.
> 
> $ modprobe cxl_core
> $ echo 1 > /sys/kernel/tracing/events/cxl/cxl_log_type/enable
> $ modprobe cxl_pci

I don't see any other way to do this. I saw this [1] but it doesn't appeared to be upstream.

[1]: https://lwn.net/Articles/432186/

> 
> Is that how you tested this?  It seems like a pain.  But perhaps that pain
> is fine because these debug messages are not as useful as others?
> Especially for all the unsupported messages mentioned in patch 2?

Yes. Alison mentioned seeing maybe 500+ of those.

> 
> Ira
