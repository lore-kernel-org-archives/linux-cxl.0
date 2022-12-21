Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700FFC4167B
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Dec 2022 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiLUS4s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiLUS4r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 13:56:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E187647C
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 10:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671649007; x=1703185007;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TObf4jfpdEpyh4xUTHNs6+1bboZZS8uiUd2IiXKOiHc=;
  b=Lb+vDm90Nd7w8QVyhDHSGskclVTz25diZZfjR4yzM2YM9gZ7bDyDQWx7
   crl2dIviynMyjLOTo1X8jgPOsKUvDwLaakx+fYd8qDKKahGlnwfIbfMcf
   xJ53vNbeY4MHITW4OO5zy5Nv8W1aKvCXpWVQzPHENP89spTT0yoXTQK5/
   adWszdhi+RVAGDLxD0awNhaRMFqN53Y+Fd4g/Osbhjbu6ZIAFEn6gTVM1
   1AhYytwkUMp5bGY/dY0j8zcfmIu9Z7LNXcqpTFb1V/vmyW/gKTywv32Y6
   Bn1vcXtlfzYQnk+5Pe7J6Ir4qVD+c8p5VZmqjc6YCeXUyEN4+j7zG2gx/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="303378423"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="303378423"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 10:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="793806092"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="793806092"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2022 10:56:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 10:56:45 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 10:56:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 10:56:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 10:56:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTjXwoD4GczSdXG9lDoQQ8uZUh8SZT2UqThS2giIbdEsJV4UAT4OOn76GxioStiAoZaON1Z3rsYfwvJo0LqJNU1wpMDLsKnujHPXKFGVNMRQWVeRFSH5s0zCuUTsF5LFU+tDBauyhdAqJqMUJOZbA9aM5tlc9jp+2L04PLZf/Iemc4CkFt3uxek/OAu6rEKc9sPQxHYgLn6UOT2nLWdugS/CB8Y+vRJkecWOXKCL6JheeSmSxStE0t+alD93gryeNLi0N/1mnGt9TayZm+nt1VTSJ4kNCYT/iVuVln2qe2/BVg8wqaIZxGCI4C2XDIA7eP6Jz2DhGDoHmaYE5F7SZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns3DTahGneYOUUfW+qatI0osxUU0aMrh8JeRlGttJbw=;
 b=kYE8lQJNYQNMy5k+ceejc1GUE82frUrYkViSFMUlhbEARh6xJ4AKQ7p+vnmblUzOhiKSNnKTv67UoYUQpNGeUJqepCt/+q2nfA64aFxOhrO6qpaDnKFsHH4XsDUd6gWk3ZEox2+gCy/x8OpS7Els8v4LgO2WENNgBK7IDhWV/ZZhP0DWhJXLC/O2UJWIL2Z4JeDjZtQq23EsS/k3n3Y2QcG2UuR+9tG85FBT9o3oFotKw5nEaJbk1Tv4y9KRjiqwi31o5pfTNktzm5hFKPS3sPK3y6CqM6s0CRKwJxLquUSY47oGQMtBzY+e54dz8cNBvASGDbz6ZhlFZOgcfRMutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO6PR11MB5668.namprd11.prod.outlook.com (2603:10b6:5:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:56:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 18:56:42 +0000
Date:   Wed, 21 Dec 2022 10:56:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] hw/cxl/cxl-events: Add CXL mock events
Message-ID: <Y6NW5hhNbGYUJJCZ@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221010222944.3923556-4-ira.weiny@intel.com>
 <20221219100723.000021a9@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221219100723.000021a9@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO6PR11MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 254df47a-6f36-4d4d-1c4a-08dae385195d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOyQFOTQ25F5cJRzhVySRNUXjIRyxkUvcN89tX8lRGKSjSFyaM1I8BgWvVhtky2fqyhZx6roxXP0bDsaBlnhhGY5bnyieScqat5yInSO91iTpndLQJmWXQpy+1uh+HcpEbSJo2+v3GHk8uHQn4xD2HwHdzAbaihRxmHJKOZAFCECsUEJf4kW4jdQhRPolnAaHO2pSyREasNF6VLReY+WD/FBwAHSMpdqNDv/bwu7eLFjkw/D03lcmnDE/jcWYvdak6RiGHbv4M0aydswlHmzkILViNaROial9fRSHjpCIihe+977gQdQXvylyFTZefeJ2W7lsvXzSyX5SwtiNis6NULx6artJpyEWrgogBDKiO/RBtJlPZACbxYTQxSgydHVzPONDL64Z5Xxf20mfT/jDH7aUgu/mguYwWocAltQampHbnpAYZnC+vRxZwkh8xiT96YSaod5Ru0G4qxAGaxHyu6K5h8J5l36o1ART0Uf02x0/EKLE7iRH9u5UXym1zgS5y9Z8HWHqkIhV743/JxWf14e4Tb68iGC+L2CSSFyBHskklbS37GgyHgsatcghKEyJ4MA7fZ+nAbCTTRPs+RccupBaWjXiJtEV2eZjP8vdPWiWOEy51yKZuJA8S2yJ75aEEUyU5dGTw2tAmK7Vw23XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(44832011)(82960400001)(54906003)(38100700002)(478600001)(6916009)(6486002)(2906002)(4001150100001)(5660300002)(316002)(8936002)(86362001)(4326008)(66946007)(66556008)(66476007)(8676002)(26005)(186003)(41300700001)(6506007)(33716001)(9686003)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wf+bP7RGElascJk9tq49tIbnXDpreA37+U43DlErW7hjndipQSSsCzqo1Lk9?=
 =?us-ascii?Q?fp6q/k8YVFOQXObxsdw5m7RzCDz2egO/4iEHTOJVwJFPB/HQdIHPSebQUKi5?=
 =?us-ascii?Q?jOgf1qOHs4LmyygSOgjCF4HGHVIAHSVmAInBYzSAQpHPv8JV1UdhGuxZq93c?=
 =?us-ascii?Q?o2i217usuxSRXw7lCwVh+WJq9sqHTrsXQw5fMzOzFcGViV+o/LglybKSM2hm?=
 =?us-ascii?Q?V/IcNFvavbwpj4bWkeHk/mq+FIhSATn+3rfdRoYZBJzP7szSAWAXWLqvVtJ8?=
 =?us-ascii?Q?zLdA5ZHfF2Sen5MXs3LIpqql5CptuvtL6Y4MO5onzHD7WQoVlvkdwVpNyT/P?=
 =?us-ascii?Q?Kq6OwWg/iWzUh5Ub0WukUJJfViRSple0wXtoYv8SB4uHASlfTFcoOUfQsn55?=
 =?us-ascii?Q?8iMgoQKqk6TR/4l90q3x3ip1tBsZkoCnE9NpFyy4m0yruAbA+WCsixNTYPuw?=
 =?us-ascii?Q?Ad5yUKQ8gUq8T0OKZA11ycgOxS+QJFi1388e/7aOaj4dSMJeG5c/1cYnB5h1?=
 =?us-ascii?Q?9G3agZ4hmJerhnBbXoRuIOnF+WHxS/UnwGuJmQ2Ky7k8/ZDKhjb8fdoWzZ6r?=
 =?us-ascii?Q?K2oFuGqQx41LsM1eKU2SUkYUUXqSi5X8WNNpUsp+AMiEDw9CG6JDYVdLSfao?=
 =?us-ascii?Q?ZZHT/N50MdyAVh4jB9msdQcWPWxC7CV+MHzUhpyux0kZMzCT+sbfReQFHoxG?=
 =?us-ascii?Q?1MmGljXKauT0tmZ5SNKc980P8ZrBvfMNHaz63fNL6/QNXawhHKDfQJaA/oAQ?=
 =?us-ascii?Q?yxkIa4GPcjBQHrdKm42GAUpI4wWndEMpf8g9SC8wiKQAudSVhqk384UoG7wo?=
 =?us-ascii?Q?wcKXPrvnXE543jJ7dNhITC4ZNk0tWAeagvcwAUxnNtoNvPCQT+RDlc9XsEnh?=
 =?us-ascii?Q?Fbc0kTrsfWLZ5X4bKNlJ1JK8lvpDorOkBmTlCyn4aX6oaSog5pMlhpkwLz0t?=
 =?us-ascii?Q?UGanTwGA7n2S2vn9t5M3KJ1qttFFXzGofNIG6xN3L/d03EDY/WJ8mPqg0DZQ?=
 =?us-ascii?Q?1nBqum2xOFMfSJdoj4BLbCc+9X/usC7lAfDogh4rB02BZmSjn2v+OWbCOach?=
 =?us-ascii?Q?bySYzLOAa2FRmbeNlrXnqsUolsDZvoVJRkU6otVt8EJGpAGcHggKuVhg+mYy?=
 =?us-ascii?Q?+bFYqvQ8BPg5/eOLi8YtxWUq/av5jt4LoNY5UWWmnPJ7o6xTHJFcDIzIIMFz?=
 =?us-ascii?Q?t1l+XpFylJ+aB1mYtI29McUe+2AndWzBMfXG496N85StDBBJCUYfI6PpDTWs?=
 =?us-ascii?Q?0LlIKn0rT0glYZ9mJePGeDnKUy0uivJzCO4Sc5B3vcvbWV7AaMT9vtuumN2E?=
 =?us-ascii?Q?Jeuy9eGXBplyMpvvC4ZQxEUkP/My+BklHfcvTkLsFOsI/03mqSsbxDol6oOM?=
 =?us-ascii?Q?1L9BljIMT0eXk3Zol0mrbJOtdSg4my7MBNiwnhsNXsTRJ4eTbQto3x7dV3pT?=
 =?us-ascii?Q?gszoTfYAXt7G5MZaXkqqLSLFwJAVJdU2mPZ3D4qerlNnUCqps3RJAzxk3N9g?=
 =?us-ascii?Q?QAXJ1eJMdN2j18mtzHKOywQXK/yf5JL3EvA9D2dBG4sMM7G4Cdc7L5NpcoOW?=
 =?us-ascii?Q?7CIEM1/7gXS40LjUpFZNynRVO3eWb6Z+yp1n3dNt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 254df47a-6f36-4d4d-1c4a-08dae385195d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 18:56:42.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GOkF3uqycydZl1tqqA5g5QUPCh2IYMoxXSqghtH2ROXgtI4rnOtUnGQTNNtVyytZEKxlv4L1ajqxaBBfW2HYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5668
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 19, 2022 at 10:07:23AM +0000, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:29:41 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > To facilitate testing of guest software add mock events and code to
> > support iterating through the event logs.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> An FYI for the next version as I hit an issue with this when
> testing resets (there are lots of other issues with resets
> but this one crashed QEMU :)
> 
> > ---
> 
> > +static void event_store_add_event(CXLDeviceState *cxlds,
> > +                                  enum cxl_event_log_type log_type,
> > +                                  struct cxl_event_record_raw *event)
> > +{
> > +    struct cxl_event_log *log;
> > +
> > +    assert(log_type < CXL_EVENT_TYPE_MAX);
> > +
> > +    log = &cxlds->event_logs[log_type];
> > +    assert(log->nr_events < CXL_TEST_EVENT_CNT_MAX);
> 
> This assert triggers on a reset as the function is called without
> clearing the buffer first.

Not quite sure what happened there. But this code is completely gone in the new
version.  As is the mass insertion of events at start up.  I've jettisoned all
that in favor of the QMP injection of individual events.

I should be sending out a new version today.  It is based on cxl-2022-11-17.  I
I believe it is much cleaner.  But I'm only supporting general media event
right now.  The others can be added pretty easily but I want to get the
infrastructure settled before working on those.

Ira

> 
> I'd suggest moving the setup of any dummy events over to a code
> path that isn't run on reset.
> 
> 
> > +
> > +    log->events[log->nr_events] = event;
> > +    log->nr_events++;
> > +}
> 
