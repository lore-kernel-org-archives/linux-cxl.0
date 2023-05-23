Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F97C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 14:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjEWO03 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjEWO01 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 10:26:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEABE9
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684851986; x=1716387986;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=18g7AjpFVF8iH/O2xK3mdfLzYLAj4EsBYVoOc2qwK9w=;
  b=nkrWG8ka0BWbVPueaHzmkmYsFeVnk2ggS0UYVsgk60KZUB2/rMpBdXRA
   9koyfRhP80Ba/DFOkhbtEni13qxW7OvjFGYawVggVqz6UhwgE2wa+yDbA
   OiYtBI/Boai3eJOqzIuSrsGJPn+G4dhXJuZ8MPREShK1iKbnqUfiR0G5K
   LsshM5DClza6stzECQRUTFmR8JbjaikCUkUEN1pwwRi1c/qeyv9bYHBmL
   SvE/xgU12ebMBAoaynq9ri5pmd3n3wKT0IBbFJG9u24UkpIrL2Om3/wx8
   YhoYNPnrnLiptUDTtSu4FZGtQ6pXf3p26V5ZXulALKcma4aiYTkvxXG3V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="352098616"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="352098616"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="828125778"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="828125778"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 23 May 2023 07:26:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:26:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:26:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 07:26:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 07:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwdYzH3XOS82OZC0r3yH+hehdbsCO6gvyUHuH5u0eVWPePNi0x6atvM3UV9GeBKQfjUqzqMQ9KLyyNOtQcC7CpN+lbpPjgsuUG51+MrrI51Id15t7W3kJ0CdhAJwKIOlHk8xBhpYoCrcUZCSd24JC3hr0NTe/U1d6UiEKWhB5pzCWY8Ehh+V5IyZ6aojvvORqd5DsWT9nJSMRqow5+xzlRhuqBGkhyg7RNxhBnY16XQ5DD6B8iWfOAYfLKtkLbUXXgziJMnpM/tcswHGugJUEF11Vucg6funmxD8cDjmPQxvc/I6zIANqnXzvIAaMQjiwlD/PdZmuEqVorRKSIcSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWcPK/7jEalyDvZXQlRWcmTRgXOFj6231pmJr1EOnw8=;
 b=TVPXmNBQ0amd9icQ41xljgvXK80fqfhve4Ls5hblPh3k/JWhPK3O48+HykkJud6nVYYk8OhOkiPXcEL1qKnBaISlvieT59/hO7MA+N6gsWR2XWsfjw65haxJKjJYG4rOXEKz0VUlyltkvIo+bwBPatn9k3PDYLDS1/DOdew7UznrFPPPpw2TVmc6/z5KcNoBc4BpexhKBAMDeIVfTKeqLla6QIFq4inssgoQuObu2GthGjvddrJJrxBJtfroPsm3P2Wt7B9jVNr0A7QZphzBbOVXYAded46A9YiSdOR1VQprefFCX9rf5mCHTMcvhKEuNh0rwTnMnxftm4/MYBSClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:26:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 14:26:15 +0000
Date:   Tue, 23 May 2023 07:26:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <nifan@outlook.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v7 3/7] hw/cxl/events: Wire up get/clear event mailbox
 commands
Message-ID: <646ccd00d7f1c_165c662949f@iweiny-mobl.notmuch>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151125uscas1p1ac7cc62cf284544e2b827d7cacaba8cd@uscas1p1.samsung.com>
 <20230522150947.11546-4-Jonathan.Cameron@huawei.com>
 <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8a6cc1-d127-4bb1-43d5-08db5b99aa35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3x9wNMkxISeD428FHQDRYT5+vXSqZE9a/kbNB/1BkC/3dIDio6g9Uw3lDKzUYe7BfJaeElM2WkB/UxF+vRZuZN8xxrKxbvJ74s9nI+G0AIFFC2mCyq2+2At6FB2igV1JaEY+ZdzBDdaYkrYw9Eq+yPV0o//de8hZq8p0CcN1+uEnG7r0Jq4lYi0bbhW9t/dbw5UMnFTBRbnY7hXBAw9Y1zQaVhkNyyPDAAM1+8s+Puzko9ux6vk3xkqs+UoS/a9pU5TmDUGLyGgztzx4run367n7upMk9/+Ln4q4h8ACWxKuW/5vddq+dvEwrCj7REiz4qoFZ7gg/1gMjYm/nlTFmFky3eq3awXukyCe9Ale38kdOfBiYDTUDEIUjp6ebOmiWZubTys+xBWhLkunUsi8Uzu/FCcIGU5Gz4kTzmVBG/MUa1LP/X5ATKP3ioBwAQc+JPnrRpNiSYX9Gak6ss/y7MdgfH+5cCgYWlOzWjAtwLMh4Gt5ymBHXHpfalfLEeIASLeJMSayIX0hNz+DC0oI23vR4Hbn/dazaSIxm2avbbEAmTpAnyyD3hYBkogY+eCk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(6666004)(86362001)(54906003)(110136005)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(6486002)(478600001)(38100700002)(8936002)(8676002)(82960400001)(5660300002)(7416002)(15650500001)(83380400001)(44832011)(9686003)(26005)(2906002)(186003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2C1GAIDwHSf5wXBoEyUgFTIVQy/UmULaHutIrRy7CgkjtoaNh6eWhAxz+21?=
 =?us-ascii?Q?x4urHx3BEJIDCFZ07TpO6rlrMhed0FT42OnVb8BUX1LA5nviJSrjZvJgrMzb?=
 =?us-ascii?Q?jOMKDcNIGzniKN4Q3omNJmGCKo243c4rY6s/8fftHxXKTqmZ2Q9kGkOW5YaA?=
 =?us-ascii?Q?ykqvOYT14Cjx9FKgfWKVNK/BlYvo7Xv2SiaRFLvrIe2DqQfXg5NQDuQdn1Yn?=
 =?us-ascii?Q?jVG9smCCoJbnlrn9Qx4pteYgvULytxnzGN0QcSSzqijnT6WMWOwkwbRPnP1c?=
 =?us-ascii?Q?qBRKSKCZ7QSzFZMz0WUB36URBdNHkhH+448ILr/IW0PaLdsMcATcZHCCMcxn?=
 =?us-ascii?Q?l1OAUaP7fdqCtsvgMPp8xQImd9+y4ps2Abcq0Vnt4WSlSuAQ2pfae8YTvYWI?=
 =?us-ascii?Q?4L6z2qXq2R3eWyBQYIa5tf96LmRwEKoibLGIA45TbzqZGt37sSMs8HABgwAi?=
 =?us-ascii?Q?SRPjsNgUjr/94BdsuQ3hgpOr1m0gh5vlJobQJlAzzbAazdBu9RrYfrF6iMPG?=
 =?us-ascii?Q?TK7UP20f1d0bBaRwOa9kUk7kuUZw5GfqKl765B3V+S1xuvIx9ET68vVTdaE2?=
 =?us-ascii?Q?OSz+ZS6XZMBLnlzx679pAWnF4M+zpwxo95RPA1Te+YFu4JPReB/y9s719htn?=
 =?us-ascii?Q?zvqjhGFeOVPVrvK/tDqPoPPiUVxr8W60gq+bYRHLU4gdF251fDmo2PuppDlB?=
 =?us-ascii?Q?FP4a9+hvtKpIZui/8Se0cAdIg7NfjXmSWb8vgdYamNE2dFHLHC6YqwZ6m/QK?=
 =?us-ascii?Q?Xhr6z2ASYbQQQJ91tHtdP+yFSEmJIP44fblYmrw3AwhnHfCAx0BmS7/t/hoP?=
 =?us-ascii?Q?LjWHIlvSX84D26CKLRVnkd2CuILBcZ15xKqmL98MPY3+J+hn8657zhvnh/ji?=
 =?us-ascii?Q?V6CSDMxHdoVDifvql/H1siiOXNnUIOdxKhOgIpO33IHu1YgTgSSMzXBinPsP?=
 =?us-ascii?Q?LklydcXyODZkECFJi8H2/vorq+TzxLCIxb0CHaTrXeq1osju9wOYLCUz6gWk?=
 =?us-ascii?Q?NxgxSk1+hmiZCqeijrPYAhgBCYgVvQ9TBwnVltX8JXqhifgC/+r/fNXogZEE?=
 =?us-ascii?Q?1e73vIv4bsl2VjkSLQ4Qokdv4q20K2g3rRyToZJduq7WeOMVN0tX1StDZB3J?=
 =?us-ascii?Q?WpFe1FrKV4HIuA7rzXZWC05Y4EaXVQt5828kgZN27gmbWkbVVgouaoK8x5II?=
 =?us-ascii?Q?z0JgcHWBM2NDx77nb7gr1UTPO4FYoDKsqjfRti5GQoFbrwXLAfRHRYQ6UtFn?=
 =?us-ascii?Q?OvztN16cExMCgQRXp8x1NKDTYMyFpHbiJfB5oadWUyOPbWdN/LhWSc1Kzr8q?=
 =?us-ascii?Q?Q9YPtXwjEiEnplvvGD4E5iiFRD8YfdpGmABJrxjjMTbyGsM4tmB2TMCOWMfv?=
 =?us-ascii?Q?Q/jLEkCUgXN7yJOplII4lSkFFXrLLsTriDFl9Xupb5rCjidVLBBqAMiyBvdz?=
 =?us-ascii?Q?9tPVfSeUZbhgC6VDbxmtWrNYCk5fOeG7Pkrvf+M7OBJUdlkZgptkHTjLTCP6?=
 =?us-ascii?Q?p2lw+IUa1Z8//j4vtSicSlatAy9A0ULccPKWiv+RV9vm57DUF2Mf02aqO16a?=
 =?us-ascii?Q?gm5SckGhbHeFfzQZBRkrZhwmigtebb3iZdK2deeC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8a6cc1-d127-4bb1-43d5-08db5b99aa35
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:26:14.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlBnc3OzsThz6U7BV4aEOZxgoLsw095aBpw7/g3wS97FpikpDBl+hRVvVfwuFUeQ8dp+ytvstry3xGHGiPer8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> The 05/22/2023 16:09, Jonathan Cameron wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL testing is benefited from an artificial event log injection
> > mechanism.
> > 
> > Add an event log infrastructure to insert, get, and clear events from
> > the various logs available on a device.
> > 
> > Replace the stubbed out CXL Get/Clear Event mailbox commands with
> > commands that operate on the new infrastructure.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> See comments below in cxl_event_insert.
> 

[snip]

> > +
> > +/*
> > + * return true if an interrupt should be generated as a result
> > + * of inserting this event.
> > + */
> > +bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> > +                      CXLEventRecordRaw *event)
> > +{
> > +    uint64_t time;
> > +    CXLEventLog *log;
> > +    CXLEvent *entry;
> > +
> > +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> > +        return false;
> > +    }
> > +
> > +    time = cxl_device_get_timestamp(cxlds);
> > +
> > +    log = &cxlds->event_logs[log_type];
> > +
> > +    QEMU_LOCK_GUARD(&log->lock);
> > +
> > +    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
> > +        if (log->overflow_err_count == 0) {
> > +            log->first_overflow_timestamp = time;
> > +        }
> > +        log->overflow_err_count++;
> > +        log->last_overflow_timestamp = time;
> > +        return false;
> > +    }
> > +
> > +    entry = g_new0(CXLEvent, 1);
> > +
> > +    memcpy(&entry->data, event, sizeof(*event));
> > +
> > +    entry->data.hdr.handle = cpu_to_le16(log->next_handle);
> > +    log->next_handle++;
> > +    /* 0 handle is never valid */
> > +    if (log->next_handle == 0) {
> 
> next_handle is uint16_t, how can it be 0 after next_handle++?
> 

If enough events are added and it overflows back to 0.

> > +        log->next_handle++;

This statement then rolls it to 1 to keep it from ever being 0.

Thanks for the review!

Ira
