Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C7C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Jun 2022 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiF1Tve (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiF1Tuw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Jun 2022 15:50:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0381408B
        for <linux-cxl@vger.kernel.org>; Tue, 28 Jun 2022 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656445760; x=1687981760;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=4FX97zK0urRluRpKhhqDclUm+CPPUyMx/BDEZMh1JEE=;
  b=ZZK0uvouAhAGcKec0Oy6XvUY6hzQiC+8fHKMoBUCyKNryJKoN/ggLKdm
   4Y/5cxxGZHH6GCauaC2oBQJLQCjy1hHBSsYKqXT7DcUut1BkIEalEAPjS
   ENqHK0l651N/+X0XUpU9KJmm/wYkZ73icEMpqUHP/1g5L9LfoM5pCdNkO
   nmHnVWeEJgY4uLGbD/Gb++zSYIWvMCEhs1w5mG4fLc6apUWJXPCa+q+Hn
   XVne+Vs+1mtvy5Kc3vz311dFo5n/Cy6P8vob0TR8M+zOPi4fCTaAwMvcH
   t530JhK60lyUWMo0lLsbE1GR+8ZNPo1XxoSIlAP5OF9IgI8fFYZrqiIT4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345828368"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="345828368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="617302936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2022 12:49:19 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 12:49:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 12:49:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 12:49:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 12:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyKZ/dOUN9A96V/TRQX2MvaMyYDF4K2RLsKwm7PoMQvqO7T61M6bvW+Sk/O7kDYsrffm2E4bj7dTKv7smxts6vBGElkplcDLIE5+z9oMBAF3ilHRXhmLS7AKWVl7ZrjKx40Wv9TTKaX99a2RT+uF9smfmKCDkTognNH07GmeemqFOyC+IpB8wGLZ5bZM3w+rVD1q1iO95DD+zGOSkuCft661lexuz0che4K13czyqzUq+893vhOs2Y0L/tFtky05IVgWfi3zQCYIQPKPNSlXdJ4RCcxrxo0Axy6C+8//KzrmNM9Nv9XL6r8tuqrqDPUjPXZV0WnVHOXcmHG3sauhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqn+0feL/AQNyvk/fFqhjWgwIre2SMayPyA/QRJVNbs=;
 b=ivOB4DE+ZfNMmOQiVehAOT85K/4FX3xmku7jK+2IZE/vTnClKh1AK9H8eRLFsYi5zjhiLG++dR15iJhG3s+d8laosw+W/9Nqokh7HsqA2L9MiRmpAipMh/ZgltPhRLJAAxk3/Z1goHvv5IAlvVTVIzYy8RFTl1a9GH0oJbCY1oiPlWV6oVbIH5yf0rjfrbvP5rZEsuq9NHiu95VqlgdRMEcxl6/wPVssfjWW2K6HOi0P4Z6dERhkBWtv3vzt5/CaOlcMl7Jyeb/N99JUWtAIxskI8XNDMw5w+66wdJKfPLsAgJ39Y7dMTyxYhQuLpafDE1nrFm1tNPxRCNGnULgOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4987.namprd11.prod.outlook.com
 (2603:10b6:806:113::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 19:49:17 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 19:49:16 +0000
Date:   Tue, 28 Jun 2022 12:49:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mani Subramaniyan <mani.subramaniyan@elastics.cloud>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Message-ID: <62bb5b3ae75b7_1ab197294af@dwillia2-xfh.notmuch>
References: <DS7PR12MB60074C18A01B242F165F68009CB99@DS7PR12MB6007.namprd12.prod.outlook.com>
 <62ba0987bc7cf_1134f9294f0@dwillia2-xfh.notmuch>
 <DS7PR12MB60077E9A94B20ADAEE883F109CB89@DS7PR12MB6007.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS7PR12MB60077E9A94B20ADAEE883F109CB89@DS7PR12MB6007.namprd12.prod.outlook.com>
X-ClientProxiedBy: MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e981d281-9965-45bb-83d4-08da593f48cc
X-MS-TrafficTypeDiagnostic: SA2PR11MB4987:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hdc0mf4siISboI1E1A3e1WxSaA7/Cw9aXRPz8ZswXtpVWV4EvWNkrOXDL+pHcRdJrJg830lCzWQii5TM0YYfCC9qvz1nBv12mf38JGReC92hYnZrgdpg+Dq9SRVZn3AlHTt96pRZHU3JIa3ODhtVVDCyvtlpdrKxDV06/H7kSzeserrXGsZhBRIL2iIOzQW2VnXSFpw7k3jQHhKg881yXpPw18sOo8UEqf/0dFbN/ll/zSJ+2procpuTKKldPN23PCUJZzrlTHftpPiBHShCRLdnIcq9BZs/wnRrTxeWltV6uOFUK+efx/TZDV8S0jnjQyRK9fcHgpU4S5AhllhssNNs/gSNJ1tlyxfm57Z1SFPhCiaMMVcRo1jyaTe7hhZ+Xbh8tjj+o0GhyhV1zXW0xMmNXcLTB+p700LnYJR8Jx5sFdv/+E6J5fKhfnKArR18ZTV6XE6ivd2rNFWertvakKV9OG1UmtCtrzRYjnMpHU7pernXyfvakocmzyi7zYBxT2xxR2BP9tWuFbSkC+88VMLNG42zzNgbxt87gpiYvFJGnGeQ7DNFmVZoxWymaThKbtmnUDMUE/7/zpLlU05CNXuGktIG0mYktg8CWn09Lq5WQaoUaaxMCIobzRyogybvcjdWgsNrF+Xjfpl9ezwWO2w9gRBXdpYWHeqYxd6/8s3YmLvJ0vQ4gXN4XYZa7PfesqBnW0/QS1+teNdo4MG/++gDiohlcv5eV2o/PYOSc0GVioFPCKm0dlzBj2Lp3wze
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(136003)(396003)(2906002)(5660300002)(8936002)(86362001)(478600001)(66476007)(66556008)(6486002)(316002)(110136005)(8676002)(9686003)(26005)(6506007)(41300700001)(186003)(6512007)(38100700002)(82960400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5hmLyufXH7Yj0RAZ7vy3WRHi3RWbJ9rawbryDQY/zqrchXcFdPkz7lsOnRt?=
 =?us-ascii?Q?xg7QAyOSILj/wLVQLnhL2YPah7POhTUCNw76pG9htWunwUq4adIViyo9JskB?=
 =?us-ascii?Q?fmIkVa1prXHrRCnOeCR93Qsy2kNRyeaV59N4UgrMIpXf1eu+oYxEAuIcTFbL?=
 =?us-ascii?Q?7dGeP0ZWyA/HVXiZ5GnnrHqZprNoVoSuLcxmeiTVEB387AGkrkbHA9MNK5xF?=
 =?us-ascii?Q?rBULaZHU56x9VhJPf4jE/O03AQCpx61GhjHrCq0W1faNYNuHTFI5He1h43L/?=
 =?us-ascii?Q?uPcJJlW181nuOcIeIIFKfSWjsavw/TPeZ9/jFAvZd5CNKQZTlxy0tRyogXGY?=
 =?us-ascii?Q?zz998bU3kM3fHJRYu8wxcw/eaRv/vWKUZBfuZYGk/SkkHhjDij8ryI6YkBz+?=
 =?us-ascii?Q?/daCeio10IeAbQhjTVBwH0jHx9EVxEsv51N3h8Hmhf1U5cDRLPdjPLqkIqJU?=
 =?us-ascii?Q?BIduOZs+V+GW3Dm/91lRzAYy38Ev35yHSj5xLtDetsarcQfM572IdQUpt01F?=
 =?us-ascii?Q?05M3kjF1ojehj6mfZhSDxmQel7Dhx79B78zdxrEMrG5rDBMWhyfXOHGu5W+/?=
 =?us-ascii?Q?cS9xdXMS0KgRl4kc6IeZhN+4MZzgqn9O3nk2fl9icwILXKrFsiQ+gWiHWDVR?=
 =?us-ascii?Q?WpekZLu/RBmWKg6URmT/REnHW5qj6HkSScCPWq+7KzdR3upnZVwd/35EOkZO?=
 =?us-ascii?Q?+X5P1VmEtR8Z5SPORdHavj1swPJodTfLj3vqPlI5ZNLlsnVFXmgJE5KLxV0V?=
 =?us-ascii?Q?OGwo74XFUEguTNnBGkGInnR02tMWrf/GnPyI7UDyc5z6CPVVhNnHbXkC+zJ3?=
 =?us-ascii?Q?Mi3OEzFxOIL3Xpyv7fdo8Rht6+IBxnodt7nUZVGzo40QlBjbaTzY3Mj1SyD1?=
 =?us-ascii?Q?fDCTyJ0cz0S+QTba/bFpLWe3JNYATuNc0scDa8oeeqtdfdbSE/cQAYMWoihC?=
 =?us-ascii?Q?59nH6wV5JkPjfCGO/jD6Wtmc9aQEIZD4zNWP6Ms2VbzD5TBSdgNfIm+OZK1N?=
 =?us-ascii?Q?dVugi0SoI7dDKK/lJLG1ATyrJ7Fn1OZkw2uC1NLqZoBpddGPCUtjt0CxRDxX?=
 =?us-ascii?Q?492WnRpAOt3+BFLqIe0qDXIHEPBKYSrO05dp3J4izEBz/OQzBj/in3Q52zz1?=
 =?us-ascii?Q?WNZ5BxD9T1pMWqzUIKeF8CUjpwWCebTbTCKS88nLnU+uV6lIEHwqUiowjY4w?=
 =?us-ascii?Q?oS9O0QpvhXyD0OK+ukutV+OHbkZescSbKTmnG+2H4me/jaQgsQIlRQVLSWdB?=
 =?us-ascii?Q?8AwlRM98c5jpiJaiKv91BeZ9f2Ozhx5Z3smi9u+juowt/SZlYs3I9zUffKAb?=
 =?us-ascii?Q?rucbcDbZAh6ZBMNsEdfCQ+X14QRwyXzIX2D7CxAwGrCAPrOPI5maUpammJ6J?=
 =?us-ascii?Q?k2gq2RuR7Adp5tBu69PbxTvd5v0GRMAzWsDLucqqszPps+HXwhNaIlQ7Z5Hm?=
 =?us-ascii?Q?9tcuiFyVwYTPODWLERhdJUCWWJYmgYN0vut7UxRYOysDTnoh0jwtJLHtHiX/?=
 =?us-ascii?Q?cW3E0FUX8Mpq/BtDu2o/BwmOYcfKTxEyge2G7HPZczhK8agKJfqDVrdCcrxi?=
 =?us-ascii?Q?63yqJ1qh3vpU8+IyVR8Jg5niAMzceVqlOBM9GbdngWZcgXhnedv0RgdP73fI?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e981d281-9965-45bb-83d4-08da593f48cc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 19:49:16.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7afe6NJ7kraMu5fZR+vZ0JpDTvk2TEmxNVspVArCpYYq2bIPq4Y5ihzcFmjbX8vkQal816KKBsRzTx9VtUpAjBbCtDjpMQq6XP/A4JO0OR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Mani Subramaniyan wrote:
> Thanks Dan for your answers!
> As for MEM_HwInit_Mode, spec indicates that when it is set, hardware
> has to set memory active in the range low address bits within 100msec
> (it has to complete its internal initializations within that time).
> 
> This leads me to assume the following for a software initialization:
> 1. Both mem_hwinit_mode and mem_active are set to 0 by hardware.
> 2. OS loads a driver (either generic or vendor specific) that talks to
> the hardware and does the hardware initialization. Hardware, after
> completing the initialization, also changes the mem_active bit state
> to 1.

If mem_hwinit_mode=0 then the device is using a custom memory
initialization flow and the generic driver can not be used. This is
because mem_hwinit_mode=0 implies a non-generic / non-standard
initialization mechanism. So I think a device that sets
mem_hwinit_mode=0 must either not specify the common class code and use
a vendor driver, or it needs to make sure that the platform firmware has
initialized the device before the generic OS driver attaches.
