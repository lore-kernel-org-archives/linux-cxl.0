Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5869BC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Nov 2022 18:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKOSLs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKOSLr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Nov 2022 13:11:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E860E9
        for <linux-cxl@vger.kernel.org>; Tue, 15 Nov 2022 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668535906; x=1700071906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hBBnvB58Mfn0fkzxD0G4YT7kqPi5jgedNeM0G2WypMo=;
  b=HVNdJHLmB28JqtCj3UfwtkQyPhKFDqJhxbF1P3XGknjCh9qWR0SiZ+sN
   jXgnmuq9AS1ah9wKsW96r2QeI/6bUSl3mzHTL76FSkBoYEW6Hq0fHt9Rl
   h6mty3YiSGt/+7KqKHMAspJ4d2ehetHOfcnag0b/jq/S/SJjC35a6p1v0
   xExkG1YId3TUwqYlJqHVUadOO/ZyNIApOs89vK5Xpe6XBQbeKL/IvMMmX
   P8F4JLqfqTol3yMlqUvDPfxTw8texCI+TaUcGrlusosgAKOFZjOwgwg/z
   4WCTv/6KyWtqpObvcXNU1xDjxuFB0OBe97GkKnZoiFeuNY0fOA573GfKw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311035047"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="311035047"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 10:11:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968091041"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="968091041"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2022 10:11:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:11:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:11:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 10:11:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 10:11:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzuA/4WAWUyHdwED385U9ZC37w4Hlzvdl3fwXSffdMpoPlJvzp4u9K05x+U6Mj01uzHPef9ZEvq2VF0wI5HL86Zfn792MIjJW3kfq+qHweJwKHrI/Xoyb8ZTwXI41OWlCd1upeI+SgPNklwaT2773CnnBMKgoego348E6cejSndAplX0M8zyo7jWGl3lzsqNC/AEXebFcAbJqfJZFvZjylu7FnDqDLmPAYtcqqtspK6y4MPOzY6nUOLIx2EniZs9Kiyn9z0Y9/gTDwGN9fVTr12Peko04DgLK3aRZiLf4PCd28NJSPuGZNXRt4+EbP7E9kvfwNaCeGAVlWscllnpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9rbcBMmHAjHOvg6Fg5ORK28IW0tE2cPSxcXF+9Z+xU=;
 b=n7XCDta9/v8hYU/QobeiyEskZYoEfCzDOr7L/PdEmbR6sN19ZC6St3vMcJ8A5sc7L8gsyxmIIS0aEbKYMk7rRHUw6ACCzmQV0a2zkz+VTZrh6kIUUgZD+pUSt5yX0OJyOJ1UoDDt9WxTvCKpTd7oKhfKt+Wib/BbcHrGHjGPA8ucdJ+U6XN2YvYQqoi0X/ev5y48d/f1OKBbjV9bxiUWjJGGCKxl4/Pux59FVC4v/a533ZjWcJ17uVXWdaZO2W7nVQX4L6f4f4Pz8yKY9dncimuS+UBNmEKoOeLCK00FyVtdXI9Zfk0ww4umdVlb250dX5IL6G+wgfhwucqu2/7U1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4873.namprd11.prod.outlook.com
 (2603:10b6:806:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:11:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 18:11:25 +0000
Date:   Tue, 15 Nov 2022 10:11:22 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] tools/testing/cxl: Add bridge mocking support
Message-ID: <6373d64ac25ad_12cdff2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-6-rrichter@amd.com>
 <166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com>
 <Y3NebjaQzcHTvmtk@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3NebjaQzcHTvmtk@rric.localdomain>
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: ada09041-949f-4579-c09f-08dac734ceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRgCBS4ODGYbjVrU5cjWQNkp5liH+0Ch9AytN0G3Hip6hw2BFBrsMu99i4Ctwl4O/pSYluxZ/D7Q4QOy44gvqHm1lb8MjKgZbmM7bZHq17gOwXLLolCMBUN5v8txAgksTsaNmbvBXdcv6Y9rg1H9syMMqwOU512r7KbC8lDOh9cXXIcdR+s1wQylc+QTghROIyRzzECqsYpu7YrqAMKm+hdkGevDNOoGvOFKi6267O1CLRmOJriEYmvX7IIwAEQ+UQ+YB2E9Szr794XbtfLBICCt4KWE9GuMcWl96VFlVXXBkwnVxJUbgzvva5foOG2Q6X2P2RmejUcs9r5kaMLaHxWZJdh6JbsY+z7tdoWazxpQ93ks7NBBRw+fvcBcZaVtgrGBKJo4g0XOFUVmO+LyC0mT7cEKquX0k8XcwAJsyAzjjyPD6M3/xJP+wVmITpj+tlrxz9oDHgXtL6ERI+U1oTezGFLICzZ7lnEU7Bf2ghRJzAHp8W1lfLQXuSo6/scRAHzL2FJbTVRRqZxEmk28uWTdLb1AiszdM8BFCwPqol+UuY7O1BOXqerGia0FMjt6ZwzSYr5Rt88lTjpUZc9iPcyHk57BpTEebopS3VpSNnOI3fmSTcMwoZOjr6aGl+enoIf1epf4eMKsqaoPckmVdcLDkCv5HGGqSMKqgCEMMgVAH5TX0q4JHOjqIM4S28DxMTYuTh6hdOLEu+8gdL2j8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(4326008)(2906002)(9686003)(8676002)(6512007)(66946007)(26005)(53546011)(316002)(66476007)(4744005)(66556008)(5660300002)(8936002)(6506007)(41300700001)(38100700002)(82960400001)(86362001)(83380400001)(186003)(6666004)(478600001)(6486002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00JseiFr59U9t3StMrMMIobxxsKxWyeUajspiIeh9o+GaD2cYemIVpJKNrDx?=
 =?us-ascii?Q?zffOrtPCMemk5oXVYFf6BLcxX21LnKXsB6m9xKB2D4/FL2dWlGzKKqGkoOln?=
 =?us-ascii?Q?BnKD4veojUcck10C50zRggRkvW4doM09Udmhoyhbz6Pq/ggeoW8fhRgKtDOf?=
 =?us-ascii?Q?2nkwle3U9cpIusuDcxET6PJEWkApwJmtfQOzDjYkWf7ban1WXeEDZWAuscnl?=
 =?us-ascii?Q?Je3AlzSJL3hEbX0b6YOKT9XwqmFJjc+Z1gyuzT4VxtptWzLD5ZmtqyJvC6a7?=
 =?us-ascii?Q?RWsbjGTTndMmi7JDikHLvRu6qalIa69lVDYkVBWkCK6H7/MprAqx0qezjpUr?=
 =?us-ascii?Q?0h880QkXfPxv27xOVZW5YWDVeWVCLT9ujZIcUteQ1ga9R/PFtPHe8mnYhTrF?=
 =?us-ascii?Q?Yp8TZfCflW3Ou0aeBC7qLO83QqOOEt+Enid9pWeZy/osSD8OI0KaJxB1uQ9i?=
 =?us-ascii?Q?aoIr24vG3gO2MBlVSA7FqsJnPApdZX5seYPHUUnP4IemqaUJTgOTJN6eLYlm?=
 =?us-ascii?Q?i7+qfd7RQ1LXVyEnFZZymGE5OkBkwJQtYtUtJpGcs5yJG+kk1zfykD8m83ty?=
 =?us-ascii?Q?wOoVXsJAw077K7ncuw/RSOOb74etkP9s4Y6niZ7kc6jEJiyv0aQw5jmoFLCy?=
 =?us-ascii?Q?Jhka8DOnb3SvPD1svE27WkvfWgjRKmFiNMpb56Wge8Wc3ecMc5nHdcAlqW1P?=
 =?us-ascii?Q?YqkIHtNq8H/JJlp4s3wwO4PLWASkI+imPb+QWfrwJFIpePrszw+pvmXJ7riQ?=
 =?us-ascii?Q?07GNVxhupdjx7H91GXSO+4z7U+neRq02E9NBvu83V92uwMskYNubR/CsDwXz?=
 =?us-ascii?Q?dTj4HM5IN3FNCvOEAtleL0lhURFTTWt8s0AUhplHSIkLuW/jMt26IgJm+hgz?=
 =?us-ascii?Q?q61pngyoKk7rQcYMpAbJbF+oHv5EzMUTrkWQrVjePVBtq7N7dEJfOuHM1qVx?=
 =?us-ascii?Q?hnx2niDPoEX5rLveY3uKehtUqmiH1SQ5+3MFlNkcjvML9j6IJ/ADfLf8HB9Z?=
 =?us-ascii?Q?tY1d0MIVAOLEaoFs3o5VayH/iXlYR6Rv0lRaH7EWXs7d6n5zNOUoDqAYmVmu?=
 =?us-ascii?Q?basvTFWZb8A67W7GHW8IyCMCoYiCoaTt6uxa31BSoQ94Dsx9txNOZ0s4CJox?=
 =?us-ascii?Q?joYMniRQtj9QW+xi3nnRE5idjkb3fvKq5Nnyuu0KJscTDa97FxERqwXuv/+R?=
 =?us-ascii?Q?+YwNzpduPEJ7yUYkkTy2Qg8AwvMeVsoK6m687a1RREBUGWVxShUxzuQZs8bm?=
 =?us-ascii?Q?pqDfS7UdPItYzAJi4dQg/B4ZAjvWSKh93UZoCrFGR2zz/yDEUCc7K4aSbcRd?=
 =?us-ascii?Q?N/iFV1lRXJq/yJmUW4GM1wkVXtp2Z5hEsn653tjK7Up8hTj2maKG4p+wI3j0?=
 =?us-ascii?Q?SWd8XJ32PsPucJfJofXuOi2fAlp5pDpH4KiUyKIGohbyjAYUQfjBWl5QGfnJ?=
 =?us-ascii?Q?lRhrIr12LE1WDn/UFzCB1TlUmUN2G9NdUJQQordnNRkGNdj73Lf4AoiScre1?=
 =?us-ascii?Q?D0XJySryL0Ptu+3ja8CD7SEjsI6VrpMlQRkfRkFgkG0mWO1ob0HhlTfzOqJr?=
 =?us-ascii?Q?tONtOPWeZJTqtCZo8PleZZJrbf5/u1ACZO6JqTrJgNT7KRNP+NF2t5h8fkrS?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ada09041-949f-4579-c09f-08dac734ceab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:11:25.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWSG8FBqAQ3nlwNnwkxy5C+4FS1AE+DxS+XYCZrSnc2cJ0BBMoioW0Y5l9Z8BTr5jSdtvHXdGNit8yz2s4XSraPpdeznVwgA5KTpEFl7Pe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Robert Richter wrote:
> On 14.11.22 12:11:13, Dan Williams wrote:
> > In preparation for cxl_acpi walking pci_root->bus->bridge, add that
> > association to the mock pci_root instances.
> > 
> > Note that the missing 3rd entry in mock_pci_root[] was not noticed until
> > now given that the test version of to_cxl_host_bridge()
> > (tools/testing/cxl/mock_acpi.c), obviated the need for that entry.
> > However, "cxl/acpi: Improve debug messages in cxl_acpi_probe()" [1]
> > needs pci_root->bus->bridge to be populated.
> 
> Patch looks good to me, though we might want to move the
> mock_pci_root[] fix into e41c8452b9b2 or on top as a separate change.
> 
> For patch logistics, could you merge that changes into the rch tree as
> a new base? Right now I have cherry picked e41c8452b9b2 and this one
> as pre-requisites of my series.

Yes, I re-rolled the series on -rc4. Will post a new baseline once I
have the unit test topology ready later today.
