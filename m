Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91826C19F2C
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 05:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiHPFZN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiHPFYf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 01:24:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1961134
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660600566; x=1692136566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QliyF3oIkbdrPDpHXocnp0KLniaEVFNj2tss5OGBZNs=;
  b=LaUyBxImopTlMKKSmn4l3Rb+T5DqMSP/90H15qKhEeorwIf8u1f6g5Ic
   v5Ivq4h3dGnhX65uAOyu8TKHH7y/YzUrhcNCXYi1+MjdZZ9txkMFWivsO
   l7LWIgXFq6aihBUJGKpsD5gmoucp5dPCI4Fkkad61pmbyh1jpJuAvduoS
   crs5RiRS0Ms4PLboR9et1HxtVXl9B860x3J3mMRUBLIM4m7jBpKSUi24M
   0SmeTZ/++MFK5i7Ma9/wHDmUyYJNDgGNrB8wyD3G47bnOFfrx2nx5GrHb
   7Rg55ZJ2XM6k68270g7wDo++L6nldeOQjBSEcYms0tVS77wbBpFDBj8x5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378356581"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="378356581"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 14:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="557453040"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 14:55:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 14:55:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 14:55:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 14:55:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 14:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsSFb3XeoXi5asDQeD0QBbFj7EMT1VigZEMaXeW+ewtsumHH0aqek3bv/YCRz7kIWHo4tfXRWucfgihE+nMPB1qKnIfvgcHfc3jk/BbrnCBBkhSUsRRVUpMjP6NCKgaio0rO7sYFubm7QhMn1D2HC+9zFvUSicoi+HJAiXVnu8cTs7hgycblUhPfRszFgxVe5P5T0QXY5bgabFvM30syC8GJ+mLsdThZ1+BDTebjVyK2wCWTRmytQdBWC8p4J3eIN+bcv+nKJJoAOm9w9wnbDa4FYrph9mQSU1DS5Bwn2YjSKpdBYxp9RZACXd+Utj9SCtUSBlK04qBj9E1/0yJBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RElNWUvKdJjccIrLsvBGxq4DPgnjpn0a4oDAhKQtnVA=;
 b=cc+y71KP4ocPe/MuiuwPuRn2wQgNEG04iAw/t//xkTj8fgNx8tvW4wJ8uSrZF9rkVDRBxF5u/s9130u2/h2zoJWTz/SVooOUg58BuhK5pA+X6wba8BHal7elFvhaXvpTV3baJzRqJbujRVXL+6AMBSCV8FaIFeJvTlIYOoAQ97OfSvZxdUmoSIMQau8E9BgJROQ0pZOrSJkOzu7chxSKCUtuZpuYBfC8vtefTNtQ/0c3zp0E2C4T11IxxfU5bIN7mI9qNSNdB6ibCPdimcHOlj3+tCD2KbsKXQ0kA8xYUYvQhCzo2dd+4OUH6FcBiGE7yArEyZBFrIBL6CkHTqpwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1529.namprd11.prod.outlook.com
 (2603:10b6:4:b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 21:55:44 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 21:55:44 +0000
Date:   Mon, 15 Aug 2022 14:55:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: RE: [PATCH 2/2] cxl/pmem: Fix failure to account for 8 byte header
 for writes to the device LSA.
Message-ID: <62fac0de2685b_dfbc1294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
 <20220815154044.24733-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220815154044.24733-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4347df33-2851-4211-eef2-08da7f08e73b
X-MS-TrafficTypeDiagnostic: DM5PR11MB1529:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1Jv2SHBNTicZknOflFiz+6/WAywb3kEFWU9sDdF2T/L1eut+BqgHrnQWAwPTaO1WgqABIzYv9CZDFTE0pUogKt+ft0Js9tjjlxUNrDhxJwwIDRaslQqYzsRmk0LNPCtHN06y4MoxPx+D/qNvO1Z3aP2gqR3RvfPFf6q8DFJW2zY7x+sr6AsPq0rqbr3escXr4+LAGleAChCqy0jR4OMwsN/Kx6EMi1H0EDCVaM7hH/cEDcXViHQ9BaSOhVXcgfQrN8y8BjbbJ1w3+av7MTgUlUA64Anz/l4YgSksl8Z3MIlDn8SYFcnoEzZnIUu2oIqT3hg+CBvsUYCqhfzs3eaQHOWq8DNO9LtojImBXVVxQ2g0T+c9pRGFdr/T9vOCUR+7zNmvMI4mxbNC9tHZpx/WcAg/Yjd5G2Ajev+QubzIp52i24w15e6Lp1807qsiflSf8RCIVZaX0+mBpUqxIL+kjOlvUNGQUpO8lh717HOHI3DhR3A70ZBWbV2MIYWOrCwvAV0AhB4neClRZV1oERgs0ai5WqOeirziHh4ufQmRxYdGcsYGNsNLvHsl4/tjGj1niHq7jnhdG0WJ/yoo4LtAHphxk6H/8QpLDSB6VAvk5/B+ahXz7ay2o4sMQn1/r562ftLNSuqne6w0kW321jmFcH8IhF1ZRRm9lFYX/ycyK3MW08Zyd92oZAoXBQW5RIs5T0VcQCk4r4IHAVw/lzkwkRlbNrFgq4aczaje6Zx3pThMfC7F5Wy5GkR4q/3hqAo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(366004)(376002)(83380400001)(82960400001)(5660300002)(4326008)(38100700002)(66946007)(8676002)(186003)(4744005)(316002)(66556008)(66476007)(41300700001)(6512007)(15650500001)(9686003)(26005)(2906002)(54906003)(478600001)(6486002)(86362001)(8936002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NXzMi7Mbq+Sd0EpSl8+5DWmbPtFp/b95Ze3E/jIJd1/ZqSjL338W2Sdqs/w?=
 =?us-ascii?Q?DpiMY6H6HR039vcA1zmLTrazhCYJHNM0H9qqHSv1yaEeXjT2CsMH/az7na3X?=
 =?us-ascii?Q?FgS7Rge0oatfCQ34U2uIpj946IoGxchdmRif7ofikAM0KV0ZeeFFp+XLHsGM?=
 =?us-ascii?Q?bP2yvO3BMPmONJNMaUAqJK5fnlL6uKraFZCSf538uVnALE4pSQSfeJ6S+FPC?=
 =?us-ascii?Q?9cQp6TxdrOIjIUCJlRSkb6jMK+kYP0JP3rpxmyBQ0q83Or1mfZmqmYGxAqtb?=
 =?us-ascii?Q?lq8Ey2IIaU/6Nz14+PUhghkkX9WNPMxvFXfH4O1nA8VXJUOQKNEo52qkB4t0?=
 =?us-ascii?Q?iR6rFG9RswuDm1UaKhn/NZBhI5/B62D3jhNOhSIJ3+01Fl5uYnDYFDhd6GHW?=
 =?us-ascii?Q?MmGeoKU10TRwhR2cyv1zHEF4ILehPcv2KynTd+4c78wUNuhJmcBjtIsJx/9E?=
 =?us-ascii?Q?E27lkN/yMgR6fDSf7cqemlWYCYaulq+ZoIp7UZxajPmcwnAYNN2/lyhiC6ic?=
 =?us-ascii?Q?8rTWFmTelkGn7biGXububxZGSrhp0mNxPQVTnC8yXJLT9+iNNjXNNykNWbLW?=
 =?us-ascii?Q?71Jq9s7qgotXFwseWGO24U/6j0Zt2g4CA8aWH0q0Mgp7dknoki/U4Qo8mcvf?=
 =?us-ascii?Q?xJ+eUJb/pPUHOxauAqxr8r4OIjpWxPM87EV3JKofvnt4y7BhjPOLjI8/gg2+?=
 =?us-ascii?Q?o7AVjrxN6BU1bYzr+6Ih7iPhjYZOiMuOyFbj0n4JyxK7pmdPMxerDFzbXg3T?=
 =?us-ascii?Q?D8LMHtbdLa36tIUHwr7S8URDlh1d5SGGagBUCsnlkxT1hak88/0WohyY8mI4?=
 =?us-ascii?Q?9qmgcqYPAECu9YQf7FdBODIJFnUAdG3lUGE1pky894CoOxjDLIOVqrYU1ABk?=
 =?us-ascii?Q?t7+k7fcEdz/4d78gTkV0FhRyWy6x9LBF1SM7iSGgMda4mJx80ZcM7rtXxV8x?=
 =?us-ascii?Q?QgQTzNEb8MXa0rXiPwb7hpjf1Mgn/dKI1jduCqmXWXvW2pGcwpEwIgKkttxr?=
 =?us-ascii?Q?RPxb3qSoQotNawOCfRQrseA1GP28jMyTkuimanaGFDRAtTg943hGxGW7OVFu?=
 =?us-ascii?Q?JTzr/FNoQDbCZIT6clDjpQRml6Bjt1mG/FpAudVShHRL9aEIcdX7e6DNn0Ja?=
 =?us-ascii?Q?iAiWDYi7x8M/OkTClCNjL/rCuy9oLbK2nm6UWcQ/pH7H06CDHE9rBG9lXLo3?=
 =?us-ascii?Q?JBNiySIS9UCgS9fsy0BbQF2p6nRfZeC2oSNH4gk5w23cAJrWzO9EJ+R5XcJS?=
 =?us-ascii?Q?C2vqxNkRXxKf9FUUvk69R8+LFhGP+UkZQrjUmw7ZCv+WT1J4+RKJV1jXqwaU?=
 =?us-ascii?Q?9eK3Y3nnSuJMTdKC7vT2bfW0O64va6oaI6vOL0XxWWCXADuPpfIUk5Ku9Zem?=
 =?us-ascii?Q?zOHHeK85iqOzjc6jXEgztSjO6e7l8y0D+FeIxT3Vry0gGfX1GVbCP5986GHz?=
 =?us-ascii?Q?1r+O6S+/kXWz++7jcJMjpSW9wA9Lq39PnXPDs1zeq7CXqhJDkIyV2qAf+GU4?=
 =?us-ascii?Q?rJxV8medT0IDhlyF8CnMdiJ48tS0wz2ShO44K23KXa41hJe5SF2/TPNQklfp?=
 =?us-ascii?Q?+LoFU/L+w2hGxK20Zu+5IPfIkBWR36rczRiWJQYMi1WTa3AyhIuMsrvAKiij?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4347df33-2851-4211-eef2-08da7f08e73b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:55:44.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr0cZEsi1krIAbHB+o8/vQ9mJr98AiPGUSuxSBtkzEt5sgX3z2dPzPZeSwwfKcUoEIyqkaePXZK5jMXchrtv6tXOo18A9sl9p0qN4bp15os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1529
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

[ apologies if this is a duplicate response ]

Jonathan Cameron wrote:
> Writes to the device must include an offset and size as defined in
> CXL 2.0 8.2.9.5.2.4 Set LSA (Opcode 4103h)
> 
> Fixes tag is non obvious as this code has been through several
> reworks and variable names + wasn't in use until the addition
> of the region code.

Looks like:

Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")

...to me since any transfer that got within 8 bytes of the payload_size
would fail.

I notice that cxl_test worked around this bug simply because the mocking
does not attempt to emulate the actual mailbox transfer, just the
logical data transfer. I apprecitate having QEMU to back up the unit
testing.
