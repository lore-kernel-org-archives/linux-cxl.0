Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DFC19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 16:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiHIQVg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbiHIQVf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 12:21:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B42DF2
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660062094; x=1691598094;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E0viHjnqpm+CVUyUcE7uKqCbKcmCcbtERwVoYL5tXzk=;
  b=R4h0QSfcjphaXCHSahDo8bIFH661/Pko6zSyb5dzbojwsOcx/daxzOUv
   i4SzMYRwQUjV9qVZGG7brX3jEFEOfwiPn7+Xdue2qOLifZMOyLkjlk1fL
   dJbKnfF7pLr8qhDHUyOCAoiKBESC/96KuYfnpi9FD8agbCqFMFlsxqAaq
   LqaxmO8kyEzLDVrzBCyfrx6KZMMmml/wUoUqEWQPVlYXwslpki4vn764G
   jCp6WTUSUA2neSyLjzPUaT0GMBvSgDzNCh7NLWaebpcHlQ5fUvZkKkblX
   gDwKQzd+3XWd/wSS427E9xASns0PS+mZsyjCln7LAzz3mNGL+yB/A0UfX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="377167532"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="377167532"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 09:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="637775338"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2022 09:21:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 09:21:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 09:21:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 09:21:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 09:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D49X9YMiErC5WPvo6Z+YWfImXfuxkdo+q/WYEAyE68YwSaxcvn8LG6PbCVTelMMpY6SU+ge/g4TlaCqiFCYUjWlNV95o1emoUSZQjVfEV6PMpfPDTUfA1lrVj8DUAgQiRDSOcnN1+Qamei0/HqNmw6Dtn5+rzt/FyYX8CnLA9TMuOXkV2TsRzzFWCTpnnNZWl2zSXT7eIQsFStJs7Trv+Q3ObHo9SukLbcajWKhSYBqv3b515CUNFtDFQx910mHkDght75PpP4tbkr/4jq7RMOA3/P7+ffk+GaQrk/q9j0UnVTOP1Tt3oE7A8jBlh61M+EV02yLwZRKoIzXkS07qlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMPrpRGhQJ5CYrCC1KlV4vB/HHTIOJMaqHrBNfSucOs=;
 b=YRKHWxMDsoAmTmBb146ICyLldSuCJUQKYSdQwS0ilawkUPZteVc140X0a+8G5mtNg9kE7qwzh2QX7EZK4gnCJ3QNPo0QnHrR+Q5pSGGb1UXv0K3G+pNKihNVCU4h0scpn8DiY4pjo5IjhmlrqWbJuQ7utXQJoGEHtnoVg8JH4c7DWBQouj4I6QmmWMCjoF1PBHs4hOpOEkXayMbyXXskwCzYwLyihrG/6BFEbymimN8q3H9c4Kz+li9H1AZAQqEtTJwiNoC8m948ZOCirSWqd+VLjynN0v8SktGTreqBiUG1iL5/LXtuyaddqXokMBbHeNctSmF8HmwVvr7Qa5MZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7080.namprd11.prod.outlook.com
 (2603:10b6:303:21a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 9 Aug
 2022 16:21:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:21:28 +0000
Date:   Tue, 9 Aug 2022 09:21:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 3/3] tools/testing/cxl: Add interleave check support to
 mock cxl port device
Message-ID: <62f2898691b06_1f18b29428@dwillia2-xfh.jf.intel.com.notmuch>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999282767.493131.3574006385715039923.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165999282767.493131.3574006385715039923.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f47c26-a815-4659-07f9-08da7a23366a
X-MS-TrafficTypeDiagnostic: MW4PR11MB7080:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wa1eVgR9bs2d7aW5zCKRxgBMPCENN2PBSxqVq0T/SLQkKyVh6icXTgDzNFMhocmdxPDyx+Hxuq31qP4/THWtzFfzjpa99bs9oi2MeEAh1ggqvWtBAcKpvP03BDlp974oLEVGD5323xA5en7FwwbulXPYdzRcO/ChKoCMKX7rZf0Riwi8lSOFPweQw69GFtTG7BF5hFU+HnnB0b24QxjNJHAmqTFDK+pSCxOTEzBSXz3XbTYWHAvVPed0TVbaHrmiawNVANe+5KsEkU0neNczfDgTYcuZ38OoMDxKXJrLonlaNt4JTIIYTAED7cvsxigAsTZ/bmLCPM3FjCLV9SZiBWGX9MMtfImFkvgleAveY1E4G4pzHX2oHMAgMLg9r3dtceogstwe0Fo1yH6AntNfVJqbtqzIO2UZVNKyWUgJaWUopypH1sAOd0Nb7xhlf+RelcW5ban3RH9H1g82weZicOfJFEorg1kORhp+gmv9Kq/42p+pMq3cn3tmFOgSYPCSwGDiHybR59ekrcrJ2SBPhDemgF+i9WtA1Zg6nPvFsBARvs1J5wQ6MpcqIBnZStPjXm07HuliqDiqzUqgQKDWkpJT7h3YJk5Sj/M0nCzfC0GozQJd0Hl7AQUCuPQoFwRdeDwK54h0Z6j+SMrazgpL/8qYFhl2PEfNiOS9M/nVBqOV/lUgjpW1bEsgGwuLe5HoZfoW9ic3CSNwkiHYv978y14RDTcW2wUJnKWdPKKZ5upk5cLxn9oAobqgfebJr1Az
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(376002)(39860400002)(9686003)(6512007)(478600001)(6486002)(26005)(316002)(186003)(86362001)(82960400001)(2906002)(41300700001)(38100700002)(6506007)(66946007)(8676002)(66476007)(66556008)(5660300002)(83380400001)(4744005)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6kb9L/dlG5zAgLo+GhmC33vFRP1vFjupDrhpzk9NFd2ZX7HUN3+4FYDX92r?=
 =?us-ascii?Q?94jRYpQmXTJP+aqHlXPtoYBcpOjwoRmF9cN9RaHTgDxXlRTPL6KeywAvMVpX?=
 =?us-ascii?Q?waiJDmpblvHM544FT8mhXUjLStpYY+dER+DJEw5+lORmkKU6TIY6TyapxuBx?=
 =?us-ascii?Q?BLc7OKwDHQPLJAqRDWgJaVTFZ+8vpRA16y5kQG2I6C02e6mDVOt8i+cLqboy?=
 =?us-ascii?Q?o+UzHsZ7lwss9cT8KLQY5slp70N7n7bYe9K38MPKjt/k1NmvjBH8nMqucqBU?=
 =?us-ascii?Q?PN3Zv9IJ+qHnjdfZACIgVs+wNaL50an9RGbfOWOdnFcoB3iW+4nrB4VVyN0u?=
 =?us-ascii?Q?iYJgCGjVUShNZg3C6g1APIJxzhQV8tMa35m59gQ1bHjCutXm1Zap4EO4vTVr?=
 =?us-ascii?Q?vRg5hc/KUaqtPAcZD/QiXOhQsW6MhjdKNJRPzQipygtf137Nsoz5fJdd0MS9?=
 =?us-ascii?Q?xlg8d0fAQM7wAiKYXo2pcuHMKCoiQJAgDFvI4LfsQ9LWDfpUZHuFrbPEAq1l?=
 =?us-ascii?Q?m62z/XFzHZ9xaFVPJNVQLtmybmliq5XfzT0QMF6pQSrmrJeYrLr9POOQxs4f?=
 =?us-ascii?Q?o2+DgTztYLPyzeNhWQjrLzUnHEdasXPfhEMgTN0EQupZm9LgTVndrDQtbEbf?=
 =?us-ascii?Q?0oisGdtR1YpoK+G+Y614WEVZnfXn5ZIwHjypTZEO9uCqbSxny9IeAWuz0kuO?=
 =?us-ascii?Q?+JC9O4E7OjYYQxWQJyE/HW2IF2eaXcS/SxQZeA5I+Gp/DyJBcemZhEkbqJx4?=
 =?us-ascii?Q?cG7xm+3pGfHKgrVhe1zF4BVlJyiLGBwtNIN/vkso4Bn6g5QPalXKWYsI4Jm/?=
 =?us-ascii?Q?mp0VMaAJicU/73jBbWhcPHmc89k/3I9r6dHacygujVDNoA3myvWo8UwGhMTT?=
 =?us-ascii?Q?bU87S++O+Qjtvkiz15hT6r/rHPs1u7iQh0gvxQsDxdNc8+k4Stiau0y9tGsX?=
 =?us-ascii?Q?qxxU2lJvUm8FBNzh5x9Zr5JbjcSIaY5C12FtailexHlu+INE3zQ0Wv/DZlnW?=
 =?us-ascii?Q?LGptXJIz85gmuGKVNmRAU+pgV8rGBjHin8v3IBEeQ6Iy89HDMHfp82WOuw7y?=
 =?us-ascii?Q?W8+adi0ijhFQDFdC+PNpqY5gVVjxJ3sNYAljhdwZvCLCRrZXozL0HjVSLD2l?=
 =?us-ascii?Q?eE4Duo4hiagyFtWcN9KWcb+xv5D1akjjkt+mWLQYFrXl56X2txUhNwgYtrLp?=
 =?us-ascii?Q?n1xfLdLUyQhMaaCkAH2l1YfVqafjHpDCT3jjS3IxMnkJMuM295Y4JiAE61CN?=
 =?us-ascii?Q?orAMqo9B0/nRsHBLSMfFCfQzq6gCntOsS6M5+gFtMgw+oWxEFuu6HKsgCf38?=
 =?us-ascii?Q?zvVBZSc22iqm0hFYKa13Tnet81CsWvoeRflW9K4Oa5/ZfzAsZjnW/OUUPE5T?=
 =?us-ascii?Q?Euz5WztQrrBZ/Fu/bsx8U1twXi1JoG7WqsF1C9rSwynG2MavqQ1bMiJAzGQE?=
 =?us-ascii?Q?5WnmMjNXEk6cGPuaXeTdSMkeNmCIzcXPHHyHeH8dBeEakFGLJUzS4vE5dbXn?=
 =?us-ascii?Q?m12V9c7cPDBVmmkZ4gFZ3JCwHxu35L7AKS0ejfMBLHKLvIOj4LAtaUNmfP86?=
 =?us-ascii?Q?9BdrNJBBU8mJhHOsvTpjhrooB6++vJzy03/NZDRgVcVGo3Ax1adPTQvAPF1N?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f47c26-a815-4659-07f9-08da7a23366a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:21:28.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqGXsUonUeLj7c9DnhZkniRdONJ422vODxp/Sx9s7q4bDfa/pdJJd7XKvjXZsPlBGLmrzVX5qo6m8IFd/PzJfL1IP6EwaNYKmUh6AeQFgPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
> to check the interleave configuration. Set the interleave_mask as well
> to support the new verification code.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a072b2d3e726..5a9f33703ee7 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -398,6 +398,8 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> +	cxlhdm->interleave_mask = GENMASK(14, 8);
> +	dev_set_drvdata(&port->dev, cxlhdm);

This would also need to set cxlhdm->interleave_cap.

I accidentally called it port->interleave_cap in the last mail, but it
belong in cxlhdm.
