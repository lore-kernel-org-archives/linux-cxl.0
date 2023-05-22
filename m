Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCDCC7EE2A
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjEVURG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjEVUQr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 16:16:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E2E0
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684786603; x=1716322603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jvaHRljvo7h788Aped4eVLfiu3L826Gjo9eaTPq2/k0=;
  b=PjFJxJarYn4oJaOGkjr5kiaIingWRGKyUvXnS+w8Wl4aMkKzhrfchT9D
   F+c6VAyugjKjCTYtuwgSQ+hU/B/kFeHbFbl7Evd5IEkCUYNNMBlGAoMUh
   lfirx4p6TWQapLFds5Ax7kYajyEkul16AXqZDQW1hHdULv8VrdhVgGYT9
   sFk+R2uXHhN3AGDUfbEksVGhYoWG+eudbzlq2QaxiJMruq32vHoItuDZY
   BitOrQgRcZ6L0U/Brz4nQAHZNWLdQpMUmUBa9TXlmVWNd1uLTbSaFQ+jF
   +cghjxG+h2H66eQKlDBwQckXwQwfjoGKUgJaP0B2O0KPO/HTcLUNn6jXK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="332644403"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="332644403"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="877877239"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="877877239"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 22 May 2023 13:16:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 13:16:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 13:16:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 13:16:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 13:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzqPh7xmAwiBW+4k3irvTXw0qxHsoYA9UCOxnZS/BzSUdA7TVxoE9MAyIULk8DKBQQUvvctb6MY7v36H5cra8UfZ8Jw/sXFcpIWPYgbo4iwHZ50ousMDc79OBJHMu8yBaFsd2c7argl8PbK/ubT/xLyw43yI5ZybiMnoGbCjNx/t53GY5gsZrsHHR5JwwRdsKGS2PYEVgmRQsiGR4ccPAIkbod4BZWqcNLSSptTOJij8vthiCcvUrBb/QwnPmRhRAZCVO46d14V26+OScNQbHENxBJ2Wj8cddQh62yvFJTMH40r9mdWjrc2rLPhmQe94bdov2o9SvmvOJSnHLunlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW58RTbKdD4SjqHb6u/7zsP9HNF5vZO43/HbvKQKt6A=;
 b=lqbOvBZfrssN0eN5LFxPeOVrx/mbOZNRa8DD27kFT8/G0Iy0m1ZkIr//gcfzd8fJ/YR/yXB4rvVoCQT/4e43fZ1ISl4ZrXPqzHTW9mLdUbgcZJ+5fz3k5etyIi6dR19znKLx8sEZOsvUtlD+R42CYqAgJHtT45oMBtd+UMWJC+dmRF6S7+mt9w17cJZuusmPoueHi1mXv3hjckklNINecabOCBouaCcFxvc9Jt+ZeTd8rRngvmeonUU2c/v6wpyd3TUg6OiPJ5cU8CBxfUgE01ppdjtpZM5UovyzecRVzU8CjxjVfqGLgBnYEPQNm0qPOfiLTHiojvTtg/uma9WZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:16:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 20:16:39 +0000
Date:   Mon, 22 May 2023 13:16:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <646bcda53c22c_33fb3294fa@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
 <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: f320c88f-cb92-4f49-c5cf-08db5b01736f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkObxXIaVV1EU4q9QwGl4llkhsPkAodwykvvVvEByQfMAumQYqK9qAEx84qkJxAfeGRmCoI2vREX/ortyujKJ6JXg6CO2Oyo54XFHfjgyEmUvS62D4p+GeAj5lFKRBqjmxQ4BKHdNgbh62QBStyuPa328wA+Lx6f2iefo39s3peh12LmyIbu9bkOnnm6tmibODeYJ6URpPzDrIF/bGXKDPhvdbN7N7wYZwwW9V7CaGXrVOykLmA7EiQODtewThu3rtdJD/WcizBMfz3CbB/x9Sp+BqopdczYnqqs/bsWdpaAlYvu67In4y3I6hjzKVTgguytOgdX/nArlr6sbdDWLwiWVNTEk3+yv2Hxf8LAI+US3uk3T0/NQLBZl461jus5i+pEpQBJzgxJBGGZFu2y+EQqnNFbSnzdXMonW7lbo5jmwtcvg9J4UkQIWgZ1vojbzWQkVvIpGhfNAlBvN+YFwHDbJePz/SIx++/DKt93LtQeF6lC1uk+xS5VqOJL5rOPCHKMoy8i7tm8Oml92H95YRhuVW3kjcfcKZL0KraJ7MmwFA16ads3q9fvs3kXqwFZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(82960400001)(38100700002)(66899021)(86362001)(9686003)(6512007)(6506007)(8936002)(8676002)(2906002)(110136005)(478600001)(186003)(316002)(4326008)(26005)(41300700001)(5660300002)(66476007)(6486002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uj8J0QM9FQngIbJgoc6Npj9ZaS79mP7evIpGDHQQ082IOFl6Cyt4XaKnw0hY?=
 =?us-ascii?Q?sjJILEDv+DVGCuu4kb5gPKp8+4axwqaghqL9iaWEGWuz6BNMKTfQqKu6E0MG?=
 =?us-ascii?Q?x75fzpujAdcUOF2PXyqHJcasMrAN/+t2G1Gg19CgMBwNd3DlVue1DiZBQLYl?=
 =?us-ascii?Q?87N5+IzRv79HT5SF/OkeOc1s4/KyJU/jt+s9aVPMFhn2JyIYYPaYb+SsnU6T?=
 =?us-ascii?Q?dv7GHN9YfsPoZko6SM5WWVXLYqIYAwNMS2IqhEyvpwkd6Cc8sZ4ZrIl4mGuX?=
 =?us-ascii?Q?9aejDP1KElCw9tz9xQk5E01ZA1Ly8sV5iIi+p8wE8ggGh1Z6xOHayHcycuUB?=
 =?us-ascii?Q?dWIRC9eGUroP0TsOh7+GMgsjVRYv1rmtKBsw6Xnj2y10RUVdPZhIG1pzp0P7?=
 =?us-ascii?Q?NGZnvnSb4nuELlxKcLk66cfdvDw78qY3KWwoyg3VIyJrIZTjsYJKe/LmhAQI?=
 =?us-ascii?Q?YKrUsx3nc2fDO9zc5PNsUyinxznSKX4QoGcrwewoKFkBiqjFIF1NJ8hK0AJ+?=
 =?us-ascii?Q?suU+Ll1RxomDbvB8WgmQ8q+J8TPTtPIoVMpZ/b6Hw0aLTXaphh+e3yYOEFZh?=
 =?us-ascii?Q?vl1kUGk11TS06VwJg1OZ9tmUO4y2C541seUb7PQNCeFoVK2kQF5rZY/dTSEm?=
 =?us-ascii?Q?dOE2WsUeI6q8k1R407RDF+WCMz8WlTUHylA/DRqmyJjs8NsPLrLbxD9pwiIU?=
 =?us-ascii?Q?knnz3WzXhVRlnfwtWZqV4f5AzhPB21GHmGW1mJgmltIaExaEQ1EnTr04Dei4?=
 =?us-ascii?Q?R/QfDoWcY0b1pkf5A3dz6/XLAtjFSYg93gYvWhosyP3KOAL+Pio8apAwQnqX?=
 =?us-ascii?Q?tzDPrR0lPtNvngPGdJxzKTD+mtwlDBq1T7GeG+nC6Y30YDPSkkUEajqFx+Ez?=
 =?us-ascii?Q?U1ZfuK3lpBmO/sIyf/uxdk/o1Jv6bs4dhpyRSCTw5QsF9x+ekV8TzW3GB4Jy?=
 =?us-ascii?Q?IQ1miF8oz0yjQWlQSwmDSi35M5abCpNeJZ6bOJT1Eq6VN9QAsgq39rCSVvEM?=
 =?us-ascii?Q?9H8Jm+ZoLr9qRfa0tocRLOJVK0cdMwtggqhJEESVrDGO4mGCNxSSFuD5v2b9?=
 =?us-ascii?Q?xZ1Vew+Xt8OuOSmgjwjiA874uS9kTxUWxGkb+MGWmy2dXtAIV7xXDIo7ogSA?=
 =?us-ascii?Q?GPyYcEJYXxBE4aN+0F78HDPQSpptnrspBLPFNymJUlZinovoSKxedyj+oEuU?=
 =?us-ascii?Q?cnj1+BZnyDgrHLBmAxGwvZUFV9bvurnRnR0xX+jNvTuY56hnKLzcOOiHZN4l?=
 =?us-ascii?Q?Xy4f4wfbntQepFqsYTfvuwGIGTqLbSWtSuWqifbfleQRLMBTak2J5GQdFQHm?=
 =?us-ascii?Q?Xgb7zJgI2K3ZTeUXJdujVljN7+SHUQnNoZHDhYkAVep4tztiSWx2qthFSb59?=
 =?us-ascii?Q?uyEke8btpX81QtgT71fgbSPLFT//OVJfNMnAHdUEvM9Co57Odq6ESfQeRU17?=
 =?us-ascii?Q?LnmoQpepge7o6SdBWAMqLXpD3yx8ZOe0vkIPHscj4J4ARGdVOs4v3CzRpd4d?=
 =?us-ascii?Q?E2Rl4jaZAlWsEUv0h46fgVApeNrkNeKLG64osXhr+G2KOamazzjXjekQ+UC4?=
 =?us-ascii?Q?WMgdUA/61rUOyalW+VCqlC+YW7aa4W8/TJT2G5F0BCPEwVAa3cY3zSWi5v/v?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f320c88f-cb92-4f49-c5cf-08db5b01736f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 20:16:39.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsHuzNk/Ov+1wBy8iExdWBeJgnFBa2HRBq7daG4/TIyGFEcRZD4JZsS4rgtcVPd9NY9WOmOz6uZLbnr8IhWCoM0SxYrJPNBxMviBjH+fZ1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> It at least removes one point of potential disambiguity. This out of sync
> issue with timeouts was one of the reasons I originally proposed dealing
> with all bg commands asynchronously (which doesn't prevent users from still
> time-slicing). This approach is supposed to make the code simpler, but leaves
> this mess. Currently we state:
> 
> 	 * In the event of timeout, the mailbox state is
> 	 * indeterminate until the next successful command submission and the
> 	 * driver can get back in sync with the hardware state.

Right, but my struggle is how to explain to userspace what to do next.
Does userspace keep submitting until it gets a successful acceptance?
How does userspace know that its failure is induced by background
command collision?

That's why I think it is ok to block and wait on the previous background
command completion when the next command is submitted. That seems to satisfy
least surprise. The submitter asked for the last command to end in
failure and is asking for the next one to queue up and complete.

I think this means that cxl_mbox_background_complete() needs to be called
before every submission and needs to check for "background operation"
(mailbox status bit0) being cleared to manage potential collisions.
