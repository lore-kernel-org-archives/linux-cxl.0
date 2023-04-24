Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87CCC77B61
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Apr 2023 21:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjDXVI4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjDXVIz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Apr 2023 17:08:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0049E4
        for <linux-cxl@vger.kernel.org>; Mon, 24 Apr 2023 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682370534; x=1713906534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4hIpdcJdUSbteXVbIoHQz3NlcYy2ycOPngSCy/hD1Uw=;
  b=hDZiz2AIUnJpgXPNSKAY44hLkMl//6srBBmL3PIVyn0W+KNOgDdTJQwP
   0QIueexUsq1FNqdu+YpJD99PUgmysKd2A5Ip58DlKL9GwBsIvDSapT2T2
   G/VrcUBfwF641uurrp8Go13whXcaySl3qM7G8KkDpIIAxfwDZB+JqDtrZ
   kiqZteBGcL2jqdUmhmpO2sYr8+JdTd/PczgbScJOn2dhd4hlAehIgeDyq
   OGhFakgnQCDl/9nIPLIY5VrhlQ8LYgF3pWydnVuJgGS39BkfuKwzjBJuN
   P2eyE3MA/C5LHZ7lIEwpaAac1Qglk9TUODQ+7YhjF+TH+RhyZed1qK5bW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="335457079"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="335457079"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 14:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="643518864"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="643518864"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2023 14:08:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 14:08:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 14:08:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 14:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cau2SkpGHuNsQiY/PUn8DOsDj4UdPkOZJfH5YeMW/NCPzifecAavLVzbpoi/pJ/jKNxou7yFmssyctzN2C5l/5tTsdwxhRNU3DYUzHLrOZZF8M6hR+HBNEH1XpEnjPFj3hrbJMzh2kQsTobbp5dBOMrllP0gMrYDTpC2utwCF6YfmQsw5UPT+QuzD0DNmfmbaMNZqF4jl0qVg1a/5Vduq4z+7lSRc0SsPZS1hIJshisuszVJFSFchFDUTh0QEgszv+Pk+Au2Iv5Pph8gP/RzRTPP7jYVvDBhZBUJ2MQFpL94ZDV6LNA8QSVTcXiolTNVJucLnhqPsZZ3KB52kTydtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIPTEm3BHH4XwigTCwOLAUuNWkwRtBS8EFoPtnEDgfs=;
 b=k2d1RJHPRZu2J175DRHE8ZFH3wOWuSililwbEIuUA/1HfAeJowSyHElkfrnYzB1TIF6QIRtGewYV4RickEFT6ZqzPE8X5lurk1hUgyDCjPawkvjRrV5EAhtYzQhUL7lTsVAZQK/1GzzzJ/B3LLxIG/DcQjrwI4XDLP2n7xitVxnTGY932IRPSHxkEdAvSrpQAMjqIbxZnLssCFhyBqmjsznCv1WQKra+dVdl1yolLLQkeNh23oQJYgUxChH5iyZFeDYIZGQEndEQZ0wXOv2MT6pWydQeytgHlATvoHUYOtuLZambK8ddUYqJdCMhagxv2Se1oGVOcTa+lxdjJQYUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5569.namprd11.prod.outlook.com (2603:10b6:303:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 21:08:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 21:08:51 +0000
Date:   Mon, 24 Apr 2023 14:08:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/test: Add mock test for set_timestamp
Message-ID: <6446efe16d695_1b662941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230423221231.6357-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230423221231.6357-1-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b2df7e-acd7-4020-0c26-08db45081abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAIXr04vQ5OD9WbQdOqQXCAYXtMSnW3HXI4Oz90g5JAfvXfFZ0t0HhenmjpY8ZzpK5hIPC2/EKr3hHx80tqhJ8Q2gDoQql1CcTcunuhPbXedBh8nP9Q17b2EnGgqfMj41NXF8VacSzFME6DOW9Y92MpYDBAFvE9uMn0i5CAL+CcHnMyFvqafCkiw6BpAQnAm88WDbR3zcAYZUdz2NSh+ZT/apTeY7HPtNcUQRraFNePmnGqCzFJnPofnV48MzckiFpKYK9bH2ANSBEh92RFrJOvcYCxjBVh1XsX8wRUydSOWPHdCDxSatyvVMltFJKkrSsTgyeyXktKf8yVLbmLyHKp2nqGPoJPzk/e23MmhUiTvTPkEwquHEkfwH0+i9GD8WH1OMcHZL/kGVUxAb8bCxodyVumDTIu00G+zTVUEcuydSj9krWuSvmRKeNZmnHV6oqM/Rp//eFek2GNLVym0M//DEJXpP+1mOLz/hcASHOkXYTOXmcL7KSBrYTGcMzH1EyIfaXHczpNk+h0BLU0tYC7XR5ChSdja/gqGTjhjQ18tsiODcfJZy/HYurTrAcxO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(478600001)(86362001)(186003)(6486002)(26005)(9686003)(6512007)(6506007)(558084003)(4326008)(66476007)(66556008)(316002)(82960400001)(66946007)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hg14wO5cDYuv+0X1yNkGUV+2EWq3gEhBFcm6HGE0ZTcgZjnjrCV+IW+kyTrm?=
 =?us-ascii?Q?INu0RIjTXOX+BWbaiUFIqqD5azidIAwepAADHhZn9P6cI4I60ucq2UfQ0bcU?=
 =?us-ascii?Q?msLglgpbvOm8D4a99ZVVFO+YNhAfyAszNsG3ezT0Hy6xHHLEChUZSm74dM8U?=
 =?us-ascii?Q?xgEhVXyx0f+HWD3pf0c42Cc2mZXOI/2xWjw1sIr71SM5X9IqNDEXGwog+KP+?=
 =?us-ascii?Q?dKkTZHVdT/v9IEatrF51x9hjz1D4JnFgDvCAySh/IeNYApEtSWSNvSiJAECm?=
 =?us-ascii?Q?mYtcjVX2TnifohhohrrU/t1pywRvW4OJmkQTOd6feFIj7zlmtShoN7cPfMLy?=
 =?us-ascii?Q?ZtgKbJyLHq3YHgvbUdS6XGF9RxrXlQul0O213DWRFGDVCd+0rlIEziiPnD6i?=
 =?us-ascii?Q?M+VcD4IOjPVlvyPxPUfiRTNN2SxrlCYJmdH2krmQYQwW9vJvPvBbfxaQ7Lxa?=
 =?us-ascii?Q?MYFFL3vOFBz3tyCg0E3I5bEAZDEaxaPXEHjKlMPRBkbEhQQz+YVujQkxwbKd?=
 =?us-ascii?Q?ptmfSkkz044MDheIjosm/3Yx+tZKkfuuGXED+8yWEuRoLX5hZ88P26wIsxM8?=
 =?us-ascii?Q?LnrQ6r5C8lUuxH4ehTJAnW3dDoR1jaTsnBe9q2U0lFjI4EKGI8Y/2vv8LXSI?=
 =?us-ascii?Q?pvy9VT+TPM9wQ6elnFe7x05dC6XkGA6iqk38e7TAx86is4L6s3lgOQiklgPl?=
 =?us-ascii?Q?WtNm4d5pPQblltl+eEfddrcioLx1VTCk7ikDJjq120vYLgYQPTgPOR8r7Kkt?=
 =?us-ascii?Q?bdFc/4g4mWgkKrH0k1xDYV33zDbSWwZ8T2SfRELrO8TLWIZ+PO9mCB+W9KyK?=
 =?us-ascii?Q?CmetpNgTXJqbTv2TnkEHV8KfAuT4N/SYdsdFCTwZQx/MzaTjlAxxjpcFJ+jR?=
 =?us-ascii?Q?vbVha1tUTsAKdaEIK5lwB2Hw3WVYfDba9WUdw2VUM/1i0s2KCH7VX1JILRso?=
 =?us-ascii?Q?iS6bubiAhidDQzYiXidvR4nsaGrtewz0XVN6ZTq+XjkWoCiod3+nVJMH+2nU?=
 =?us-ascii?Q?RljQVgxBa2xjx/9VJI1sfD1sc798+SBbWf+seACU1mFARoHezDlkBV7oMF+w?=
 =?us-ascii?Q?QUXSMtvqeSaVHl7GooZzkeiELu6fMqF2Zq1yT6lxCfFAZLbOpHCzfF3Z7mnE?=
 =?us-ascii?Q?tfZ/a/jMre8jBFzzUKbgZ0YfBIERLPOzSBt4KQSikVhNX3AsGYy8Z7kWoYLm?=
 =?us-ascii?Q?ePWCYbChr+hrnuRyYZ/Rxbia++fBfjf6JsnvKO1XYOJR3+f0WoR2n4uNbGtI?=
 =?us-ascii?Q?TFiGzAY1kXnfHvv5BzAOzzEZUFkSSB1vSIcN+7KuGNtx3DJTpBXLyOH0SuGl?=
 =?us-ascii?Q?dlUsJClnHfJZ5r1wC5sqCEo/voeLS9UpeC31IjwPrqYu1JXRLNKvKmRGz5V+?=
 =?us-ascii?Q?MX2zC0baqajn3Ng99Weu2krsgCFwI3DzVJyRXFAHECOW1uvg29KJB9CBXp3c?=
 =?us-ascii?Q?g+3se3LORPqlKWwmZ8UHulHGPJ/ZqaP0MQCoA6Iquja861508wyjjYB9PMqu?=
 =?us-ascii?Q?jKj3mXcLaB674htSC5m6TMzop43IYxWc7gcO9BkTXDDKLhhcW9bgIZvYoNBU?=
 =?us-ascii?Q?QqPApvulFYlJeN8FjrLhKJSk0Bsic5vSNbKpRampHENc+7H3LQLJS5osRaN9?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b2df7e-acd7-4020-0c26-08db45081abe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:08:51.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hPsO62k3/BTZU7cMqZiaW6/l+HXvY4Xfg/1m1kMbHpfrWTNMBFhZ1GTnZN1s/RSNFm4xtuF5Sq2JIkQRwfVjPjD1WzQIh7VOssqm1pk1SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5569
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Support the command testing in a unit-test fashion.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Resending as a new thread. Applies against 'pending' branch.

Looks good, applied for v6.4.
