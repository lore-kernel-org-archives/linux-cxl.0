Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D37AC7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFHSl1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFHSl0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 14:41:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4802136
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686249685; x=1717785685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sHtVGY1NH3O/K2j4kbbhI5UQ4yBSzL6J0GN4raoe/Uc=;
  b=WXqTtaI7O5OSi/1LkLaWATOpjKhSd7Ypk1m/JzW8iy36FfAIKxUHXi4r
   Wc6bgtI2/jaixI7KH9MHRaCI9k7T+nHPE0UzXIqC3lh6DdgspZWbrCY59
   Q3o7o1EIInCRJhLD3amfgJYUqa7EUwDgyVJRQIma3hEsyCkKZU2gcgMSw
   hx5V42wEyBEfbp1DLPbjz+OYeR17s6sY29LAblTeAh1de8tNPcTvH89dj
   0lhVyMU9mRi+9EOqVpWLPmeOTixsx06cb3xlwYvRl73bDmxjDKU2K2A8I
   ji5nZmp4tA/cOK1tiEOJ1n3QRx7vao8cMvm6K77TUEHace8j6e9XfFDzu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337035971"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="337035971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 11:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884294300"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884294300"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2023 11:41:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 11:41:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 11:41:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 11:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elpQYmaFOxFCRtHneSQEnhhGDfJhDJN7Cb3dvCjHFdJYeJLNziQwN/ki9PZ/gzUUQerC1O5bfzxXMGtQimobqcb4nlPrP+XidZCEx+MuGww78U9DQrSlS9+diL89DQlSS36Ro/3xGOfv4HiXU7tTGfvUxaKT+/eg3K8DNAFvpCJ1E2z5VMxAhfozegsi1kSR1nZWOrR0R0l+gHa2oAn627iT7Z6l3UdJZ0ztUEWiwlreoWOLtrd+u5nVIuIU74nTS23dxHjLDp0xdZkay+fmKqkZQvWoeHNR+82CSJbu5Gk7c8df/aV0lzm8cluA7fhaGJR7OfwAQ/l+QmAaII/83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c99DNd1mGDPdXd5uSm8E2qfSpvrFLqAGGZM2NTv6low=;
 b=OBYaHkYGKDC/L7ev3LYh/yrjIbtmHUYsBB1Ap6nQPEbQv4qW/9YRPZHBPSyeQDJBttNxFyPGmezkWNDSvl6J+FC0FhhW3UjU02Zf/OXVmABiw8TdZJW5fIxCXXFiR5GXijXqGOXthdHhlnOzi9iQt0ZwC/tEXwnEXNQ/SA3PzLvEAbU0I+7FL/98jvZq7IXibznFX3cMgC0Qa89OwK3//B5SrHSsRMwnkb+vuweuCGKTqLLCQDzBAaaSs1XeRvbFxd+v7WieA42lzdeDjSbUNmLDliBbQJukvSKBzfuxDPojqDGDhEJYCLApBGa14zuVRFEelsdIatH3NtLwH8bSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 18:41:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 18:41:20 +0000
Date:   Thu, 8 Jun 2023 11:41:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: Questions about CXL device (type 3 memory) hotplug
Message-ID: <648220cdade2_1433ac2949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
 <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
 <647f9d082eb30_142af82944e@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336E224E4B3DD50ABDA04B6BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
 <20230607161224.00004795@Huawei.com>
 <BYAPR12MB33364B5EB908BF7239BB996BBD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
 <20230608161911.00000912@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230608161911.00000912@Huawei.com>
X-ClientProxiedBy: BY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 628dccaf-2b1c-4138-fccb-08db684ff3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzd9ZiDQ9sS5bX/WvNzfO2MhDh+7KEI/3mvQSSBKslhXS/x0nfBh/WL81EeAYetnk1zJr4re4SFwcyLepFuSqDxcbf5X86JE0eLsBJU6U5SDrcetvWcs85+z+UOuwlp6LdbGBHDjDGPhTd5UzcSULOAI7m/RlEjj61uwGtLBNBjhWKmM3vwpLgqgxe4e5t6tKj5p0+NdgXxStgy2f65yZx+Y/kSvBagT/GaaAClPNYTNqN2JVd01yJBqihPTtcaJMeFElreLTYStmApd5lQ5aJMHCYEiTpwqSHsbvzt2h+onAuT9lOBPaL1fgrRZ+zC/gTIu0BdEizbjawKAzgnEmdsEHLZ8BOYcvp9hZCTsDhtw7deufoX293pPBeZTMcegTU+8J0SEsFr6HYpfJhD+YL83pEoF1937+aO6GPpMGtuwuEiCPyGmarv7YNaXmPHsPRUxCrpI+EVErD86QnWXqRJVTJt4HrzgGz5Yf0UQj9ZzWFtPVFyeaJ3G2LQ6ck+Rh7pKeA2JeIyt8zPxNV3uW7daIsGHBWPSeMySxBRvwpbef6WudAf2vT3Ui0OLWHHy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(83380400001)(54906003)(82960400001)(478600001)(8676002)(8936002)(41300700001)(66476007)(316002)(66946007)(66556008)(4326008)(86362001)(5660300002)(38100700002)(6486002)(6666004)(110136005)(2906002)(107886003)(186003)(26005)(6506007)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ny2mOcZPm+Ej2eA3vdUPnQ2yNi3cXCBhOfCM+IEOGs8Bd0zcWz1wCrK+TJAw?=
 =?us-ascii?Q?zFSepu/3BuZtGcFKr3p0as26lWwcA1kJldaZCV+fwPByJpva8DBKGr7bZZmG?=
 =?us-ascii?Q?TTK0TEK89oM56abuORjKnQQcLfUrn5hFupqvDZ9Xs+mbov+Tq6ubE7oBEwOa?=
 =?us-ascii?Q?4TwqB8S3YdPzOMj1drk4gLoOz+jEc1J+lV8MMgyJ3EkRscgQBqEP8zB3Kca2?=
 =?us-ascii?Q?uR/d5ra3JFJtwHBwgljyOcUJVAnC8Y0xwONATP5T9Qv9gvEIJlwR1E0B/PF/?=
 =?us-ascii?Q?a8ZsF9+yRuO8hqZzoNhwOtN36+4+WBEg7AHpg0MSuRJn5PO4ioWEvT6uPXwZ?=
 =?us-ascii?Q?8fMGy7qrdhQHArdTF/i8a9xPmJT7yt8Mk92rgwA+9dBZMygq6GNQjfRdx8Es?=
 =?us-ascii?Q?aIVwoCXZgAnEZ8McuuqFjKUmDux1VsTEGX5LFl+hrpP2PuMCIKyHFN8AjApi?=
 =?us-ascii?Q?NQ3HyWvB0Zl76DBzsFhQOhBxyi91C3mhMc7pl7ESIbUMphJjQwCFYziCSx3U?=
 =?us-ascii?Q?2NBJrWl7UFZAyZzTMYih8ox00KlHLq8CbrAF+P0EMnL0fKXhwTYEGO0ezQL3?=
 =?us-ascii?Q?NJ3ynqhWegsgUTg119q1wDXR3YB9K6YaNjD/RavUnJYuGHt0XpriyXrgcvnp?=
 =?us-ascii?Q?H1utjwN3bNNwspz0I4OtzM2KC+h5pVhZm7M78MH1dcihi8oRpziccf50F0s8?=
 =?us-ascii?Q?ayh8Ds6zByN9/2fBt9k0DFwWVGkz5YYo5DNqCXVYTOv6zF//mMDMadyiTp1w?=
 =?us-ascii?Q?Xz/hH7VHy4cPhRm4Snk7VcPpjkxthH3zkiyIWVHlAuXcBrWmF0jbriSpTr19?=
 =?us-ascii?Q?QlDgrhb13xlfiYkJl9+YRMy3mqvM7QSyCywj7WTHoUf2ULolxUviS8TNX+/I?=
 =?us-ascii?Q?QFTCJ/00IkJ2Y1GYOtKtHXHNIAWxrRpVfw9eUILGEDUMBa0vo30MscO4Gmb2?=
 =?us-ascii?Q?x/cj1kBd6Z1pxbCr+13BZPPk+QI6aWWhN3TuMXNgVdO1tkCK5sJuqZKZRpXV?=
 =?us-ascii?Q?RzQWeXRR07r1kzWTIL+UCeqDUod5TZSfyERnC7+6RlDfZAJUsP/23amWNIMZ?=
 =?us-ascii?Q?JFIA6vAErr6mA9SgrJXUlYWnYqyscjbKlJuRhEB0u9ElF1G/H91he1DsEJ90?=
 =?us-ascii?Q?r6QWjo/G/phJjOGjOo4IQ5oIEJ8n3HCTH6eg713VConJfOdTiDfG4lQlBuos?=
 =?us-ascii?Q?Ze8OTHwRJn3isYv6Jc0jrZ4VDJIgH983lSn+aYIRVIqXFGPsFdhmRUVjHQKm?=
 =?us-ascii?Q?7ELXppB4Fgst1WelCff/5rBOj1H9fv8ZJ36VubzNu9+bzZwG78Dh0iKgbYNE?=
 =?us-ascii?Q?yyO87k6rbBpjKta/vHvaHudtzomh9eFzKLQNKnVseJ59tfseOcAtYrqGvYbR?=
 =?us-ascii?Q?f55Yf01ybPEL71HqLKf2gjjlMGA7Vy3HG7Wfagw2psasGN78/quK2ULyecev?=
 =?us-ascii?Q?Vt8jVsCpqOlxCdfUKYIJY9CYa09ygRH45YyHb7OyU8I3tuiHXEpOt+N6DoKK?=
 =?us-ascii?Q?z5JebulMg9X4829w92+3mdsfeAnLsE+S2z2OqtFWsxoECtoyPXyTghm6jCoD?=
 =?us-ascii?Q?QIsuzRZ8ys5P6zPfkX9fBR8e1QmljM6p8XCNwM+fTXOVzqT01yMbUnhvCBBr?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 628dccaf-2b1c-4138-fccb-08db684ff3c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 18:41:20.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf1WIM7PZVFFJyU6gYV3VurCbtTi7HxyyVGdLYH2L88hPsx+I1q9RGe08X+S0+385qrVIZiHKkycf00RmF2TdI4aDc2R5paZnCDk73PYJnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 7 Jun 2023 18:44:36 +0000
> Vikram Sethi <vsethi@nvidia.com> wrote:
[..]
> > > So flush before to make clean (or invalid but then potentially
> > > prefetched so clean) - tear down the HDM decoders and flush again /
> > > invalidate so nothing stale hanging around (or do it before
> > > bringing something new up at that Host PA). Eat or log any errors
> > > and don't worry about it. 
> > 
> > I'm OK with this approach. When the cache flush is done at the time
> > of the decoder tear down, there mustn't be any page table mappings to
> > the decode HPA ranges (and if any ISA wanted to do an in kernel flush
> > vs FW call, and needed a PTE mapping for the flush, that should be
> > done with a non cacheable mapping).
> 
> FW magic so we don't have to care :)

Hopefully a pre-HDM-teardown flush for draining writebacks and
pre-HDM-setup-flush for clearing out clean lines brought in by
speculation is sufficient. My worry with "FW magic" is that when it
breaks the phone rings for kernel help.
