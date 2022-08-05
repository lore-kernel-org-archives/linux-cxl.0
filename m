Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D99C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiHEIH4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiHEIHy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 04:07:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0674DF7
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659686873; x=1691222873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nANzhw8h+7aMJhrieB8J7xR8RHzETTnNQrBfQOJblRw=;
  b=Y0wojGPOeg675t+bqGL3Ms/q1q+dhiaj4qThrddtEx6wefimRcPzM8Hg
   Sa/SuU9nsfsTE48+RNApMaDnZC7TkL2/AQZo1WlCppxGBEoz60XlPo2Qp
   APtV1ZtsZ3OedS9NrgCUjuYHMumgfkkKoZ0LUbjuj2gaVahXv63NYJ7uE
   HrW4urhnHmy0kqiPY18l9nau9VtLDwTiWDNYnbGSpVDQgUQSKqICd96Py
   ZeqycOfCxJ7Xhx2GQOlrfEwtV835Iuhh8UtWPp8b3I3frRoERBXF1/SWF
   sDe7eea9x0S8c6GUT0ex1xZcwp0+eRpNVkz9V0VILdO57UG9+K6ewHbzd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="290924191"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290924191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 01:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579418009"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 01:07:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 01:07:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 01:07:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 01:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hexa9tRBOZqIcMw86rmeo787HhDt08Y7iktdll3965RVJVBNGbwvp7+2va0OcjydicJdVE0oyFekfEBk3eUWDiBCL6JyeR6Sn5igA29TpgQ1g/NAPYsBUQE7EwMAxGgPHb/D+N7bUfxBihcV959Th1Epj4a2fOxb+qXy0bo8HQ7ZdOv7Rwqz51XpdLEfm1HCAkWEvliFzzx2kwwto5Yh2Wqs1kISwKPBXa0Bmhsqj46f2oaOSAz2lC7Ttq+YKwc4BHHMibMqOZ90KnHJ4gLOiB/Z1Gw2GtiC2bbI5ilTul+EGK1GnmhgYctd3d0tljrLt6oFiAW+AEWTHmz0gpHYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGnYFkeooahZRZJbQs3iBBL6oDhGfAhGlNTg12k0oNY=;
 b=kllbxpgGdUpgmBOYoBhJagoZ0jqHwIGCb5qvlyBIlZ5S5GgPwDGy5grHyvDeju9fNxZuUghYyNRcEfVPC84AVYgB4m2nqgMhvAXO7lu9lJey/nbTTyl8WQDT9RAcShnwb255Y99+q4PUryr5KRTmJc0aKxuFFH5ygnh16wT87g7f3Jyymu+Gh9WKoNkYRwK8fpgs2hes+s4QNFRVjQ3GZP5JBprvVGrsf8s0CVUtxw0QqfmUdlLcBvQHvxN09p00GU3JxHdjk2mShuQHh0MKVeqUsl4wO44rJ2ik/F9I0ISYR68YVQH4voFdQIDqmP0HrXwNbnnw50gWkwaBXk2Mtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 08:07:37 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 08:07:37 +0000
Date:   Fri, 5 Aug 2022 01:07:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH] cxl/region: reset the cxl endpoint decoder HPA range on
 teardown
Message-ID: <62eccfc72e340_151ced294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220805064918.925115-1-vishal.l.verma@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220805064918.925115-1-vishal.l.verma@intel.com>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e184c1f-a9d6-4cf5-fee4-08da76b98f20
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFOS/eMrupXXHVIsiCSMq8Z2lLpYh4b3xVbG/amFwbphVwf7b8GImTgWbXVelsU+N7gZkzySFhMAHe65Jm3Nbwb2vak7Ko9LzpfxLBk4XTp0qb/sxObp2A7j8N5W32lSNSuatkNyQvV+JOhcpfjtzU4M4vmgVBDX/0PJMFE1+DEQGzE8ZM/WjEb3x+7ysZAaYtZH6WQjfbIyb/9wYCiz/VgveS++QCqtIlcYys1+EqYNscHhnnoEMJWyZXepcn5E1hAlKKTAorDh+KemXZqjXBk7cRWu4AJBEGCyTxxlh1CzPt8bjlmRmXu8hR5olqjJm9+Ik6h72JIrXg/NulEJx0lMZp0JHbbte60On3Ls9xVmh7djoX4y4WP29R3FXiEMftHT3QTbBc/0Y0uL/FiIQ+gcD0NrF85GQkbpEsfE4X7XXyv9pGDTCXl6rANGeMjj++knLbmYLnEAbQVQ5iiNxbNe2CmIBVfZvQ0YB5oBO7cwHkyvrc0Ts0Rmo65o7uWu6H8T4AgIia2mHbkM9LC3n0b8p+stpuHGr4WuLLOO5k5nUeUMX2OIzC9NM8uC/ibz+n09JvVL9VL5aORl4Z9yMaqfsGHo+cw2eR0DHIvB3vbljiWnZpOvjyui++7boKpzYyw74V6OGUBWyMJtGrWM2GFamdx2aginLH5lZpsI/US3RdWqziw9NoIVoX/uZHyfN3xnRhHuKWxqK79wWSy2bD8B/z5wQ3bPqKXriJzYGh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(136003)(346002)(9686003)(86362001)(26005)(478600001)(2906002)(6506007)(66946007)(41300700001)(6486002)(6512007)(66556008)(82960400001)(8676002)(107886003)(83380400001)(186003)(38100700002)(5660300002)(54906003)(66476007)(8936002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKJQkHNcEztxMqjSC8eTE6Es4ifVd7WDIptT26DO5E8NiI+9/2RT7PDbn8KH?=
 =?us-ascii?Q?B8pR4X1xtHau4WmjSR0UMfPXvjl4iE5ZCkCZe0VuRREbmJVJvdDNxd1hKdZo?=
 =?us-ascii?Q?yLuPD6bY9hYY3VTNHLsgDmt1MsEbUTn7MqhjFhTbTEAsjTck0yy3qoOlq/pE?=
 =?us-ascii?Q?rHCzPumQUUfe3AIUHg7zPhUvMCZxZeRY7LllOplnFMIPnkdLwyn6mqZH443m?=
 =?us-ascii?Q?Bl+OzhoJOLZXYXa6zA8hBrdYLIGEFEIr4HcHjQL/9cd5TNfMZqeGVOb1o5mm?=
 =?us-ascii?Q?JHFaIFPK4waoTRO37EMJcfYj6N/1MNOBrA65ld4Gj7OpxLgOyCg9t34MXvZO?=
 =?us-ascii?Q?ZukXospTPd4LSNVeCVWm2xRnL13+D/7ynoQeUh+R8pKZCsrVR7GjIvQnnzsT?=
 =?us-ascii?Q?5ViwT8X859VC3dPCzqrUgjRTS88IcbtUcuvUMBfgYd2l0hz7vh5fMVD+B8IF?=
 =?us-ascii?Q?7P0hvAI7RCGGtA5161AENR95R+qkH+a7eHJEkyfBJiVRwYrPmYXwrcEYj9X6?=
 =?us-ascii?Q?ajsv4m+guh65BjG6aIwA9CBhjT8e+Y5LXafDD4Ar49nnK4FVCeD50SDOWxZo?=
 =?us-ascii?Q?xCz2C4tGFLv7l+Z4DxU1A9lnpRZNkBiApwj5nexk1Z9rod6ITZJMsaE92i9t?=
 =?us-ascii?Q?cAitP5V82Yc1dAllBKKyPVqsogNwQvboEPz2ArxBvA/w6HIBb0nIwMFlKezH?=
 =?us-ascii?Q?NPoK90KMibfoiYTLa909rdqkLGTefs+5YosxKnwbpaHSugOcxScAwhHKdBUx?=
 =?us-ascii?Q?gv4RbeHrjwNoM9JW8IV8bdpgAbPbubm8BQjr5EJNqXu7Nlg6LRLd+h8vjH8H?=
 =?us-ascii?Q?x0zM/75TY0F5Rcvn76wnT1cwDM+SQS64fu18oSb19PY5aSx1BrTZfLurBAiy?=
 =?us-ascii?Q?Ca0DqU5FbAo9Gf8q9n9qQZDO5XJHa5k58QPiO5XKTV8q5kM+M8LRFMXywAVn?=
 =?us-ascii?Q?RjeWaUa98D6p0AsqOWKJ9tblkWmvm6c0C1nNC9CftkC+j34mDcr9sTj7FEBF?=
 =?us-ascii?Q?La7T8fPjG5zcvJ/2Vc4VUWHs8xPRMV6L+tqvKidHkpoD31ZJ66gkC34FkgMJ?=
 =?us-ascii?Q?t+dSGDawxfLFq07gqhwsqOK3ZElUUnSFVA7aYcWY9+3V/jcrf3qrv6iSscBI?=
 =?us-ascii?Q?KYwC67M3cxiPu4uj8V+SyP9BBozFhnPQk02rgPyq6moWDCCp5eDbnibyQc6W?=
 =?us-ascii?Q?CPwZpWBy+9iTymOA47Z9EdR3riFhd4xW9jHr5gYaCj1ipHdPbP5zTOoVWCvP?=
 =?us-ascii?Q?i7Bua6Ljv43qUuufJFHxQQnSirek8rvrHYUL8m4ujDEFUFhgHb0j/qMz96lJ?=
 =?us-ascii?Q?fZMB02AW7c/Lonb6QQpiJfFrhNPmzg+D7NEttgsOAER3tuWXx20ixa0AO7dZ?=
 =?us-ascii?Q?wNa8DjQqIB77QuU6GRB+GWKjYDSRMgmbwYR4RFlLL4uumIkCkqphPtagKZGC?=
 =?us-ascii?Q?ygTq0FE42Y+UGxtY3DK7y3fPxQOhBGV+x991ZBNw5f1Ls9lexlq3au3Pxh5r?=
 =?us-ascii?Q?Q/MtvoWOFQ+qV+qCKAwunc3RmqC2dgOwTn0u2pNdfDMfCROxywPuwhEG8qgI?=
 =?us-ascii?Q?qfsKqy9jB2ko+ysbJjqpLXjXo+gKVGS6ZVUI/NVLD+l4fknkNoiutgRmtdit?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e184c1f-a9d6-4cf5-fee4-08da76b98f20
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 08:07:37.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1Fo/bGrfSgUp7eaHlFNs1JLdzQUskLmtk8suP6C1lmiIFxVZUajzoXuYkVaCKrwd8XhT1bwLIkVksJ9k18+NL4fd+FlIDrMNQ/EEq1a5k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3994
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vishal Verma wrote:
> The endpoint decoder HPA range gets set up during cxl_region_attach, but
> cxl_region_detach() neglects to reset it back to a 'free' state. As a
> result, a create-destroy-create cycle with the same region parameters
> results in the second create-region failing with an EBUSY when trying to
> reserver DPA.
> 
>   # cxl create-region -d decoder3.2 -m mem4 -g 1024
>   cxl region: create_region: decoder11.1: set_dpa_size failed: Device or resource busy
>   cxl region: cmd_create_region: created 0 regions
> 
> Set the endpoint decoder's hpa_range to [0, -1] to mark it as free in
> cxl_region_detach().
> 
> Fixes: 292bdc6af8f2 ("cxl/region: Move HPA setup to cxl_region_attach()")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/cxl/core/region.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Hi Dan,
> 
> This is a fixup-to-a-fixup, and the commit in Fixes: is only in
> 'preview'. Feel free to squash this into the original fix if you so
> prefer.

Will do, I think this also needs to kill the cxld_clear_hpa() helper and
call in cxl_decoder_reset().

> Another question - should we be resetting the endpoint decoder's mode to
> CXL_DECODER_DEAD while in here? I notice that a freed decoder still
> lists mode:pmem in cxl-list.

The DEAD state is a internal-only hack while the decoder is being torn
down, it's not visible to userspace. Perhaps just hide the none state
and default the mode to 'ram' when no DPA is allocated?
