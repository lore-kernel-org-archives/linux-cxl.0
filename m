Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25C0C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Dec 2022 23:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiLLXLp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiLLXLW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Dec 2022 18:11:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01001C928
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670886670; x=1702422670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h6givfoCDNd7h0N/wNfVZJ2T23WyBZlaqFEboMaT1Us=;
  b=Pnk0yHQrLWLDR3CPPTj11DcZmabzCeNrPh32+7YWDDEcNPhanYu8aEPn
   sJqYkRV1OUD07MWFNe6CHIpe6CJNnmwMpkLRdjkM8mT2P2G03/6f/Sr+h
   QcQJtEogT9q+Kg+Olk/0Kf2zKiTgW4vGwhpXxUEWgwHrI2BdDHPcQjOWg
   istNDfBqSWci9iX0+iqT+mAND823XPGPoGQ/RQCigZomMpVWnnMPGk6F3
   SjBhuHuwygxc4XooBbFPIUPOvjtbidLu2KnFUqGXGL+SRV3kq0PCZLmAZ
   S05zb3ESWmPC86NoU1pctJ8rTPqZBXfT+LZIPHBK4HP6utXtglqwQfyKZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="318017335"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="318017335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 15:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="680849921"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="680849921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2022 15:10:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 15:10:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 15:10:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 15:10:51 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 15:10:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEyeiqMbB0SinT0py4HKb8yO1o61703MsLDOrsNMpj5hJnm7CGcomCvrqbtsMNMs5Zs+t9xF9qaTP6ThXA61M6wBP54Y0yqmt2KauJ9IjWWpVIJ+iaj15EBkiKZ8Oy9DlQ1yE3iytw1VW9roXko1hrMYsWCe8Z0SFIcAI3uEu8jhzdeFmAOU7Dz/uTFhJQSW58jpY5Rdk3Z5Q6j0Z65qCn1/dDCxziLE2Q5/TijheoNJOnWZLJ3strMcOiAKeibZZCVke3k+mkknfJTmnQW9JIT4sfj/X2RqtQXf8HbH/uNz2hL90PhuCGIwGRJOeeJS9zM/YpluYmNHgA3q7yk53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAPS6SyQOc+K3lT4d1zgIz4K7tkj2RRyy2BAp6oa0H8=;
 b=j4uKHBT2zXTPD4vNwYZ5+TRMsQFuH6MAU8EzUux7dPPBUU4XRXn+bwAj7luL1bW4vfEbQd8TYJAiP+yzw0/7iXDDA2jwDXDUxIfIiVEma6rCvKVjTOFo/XFGWRfMWwqNJ9AaaOIAWETxm0EOEgQlZ22M37NSWGyGcoiTldCIapyH1MiVLVQj+LD+PqemFY4PhP5A2aOo2djHo98mYy7/ZPC4RBZLaWalFJcSh1SZ6mAa1GAkejSOHdUhIB3agU74pcWO+GA0wxCyOskZNPsOUVhoGf9oP3PQcQ0bBWXtm/BleotS2fE/ysvwvszJmA4gw1I+RgaumEPd6zTrjXMIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ2PR11MB7646.namprd11.prod.outlook.com
 (2603:10b6:a03:4c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 23:10:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 23:10:43 +0000
Date:   Mon, 12 Dec 2022 15:10:34 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: RE: [RFC PATCH v2 0/4] CXL: Standalone switch CCI driver
Message-ID: <6397b4eab1cff_b05d1294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf43e96-07b7-4e41-5ae7-08dadc96175f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qnjpytyqcvrbUm/TtkNBqB6tcN/nhteREPWvmKNxGk66eVx1e2bjq1L0dMVDD8bWYHOuFG4wphK0XAJATmbvLguoMTNhIDVLQAvShBemY5Lvk1l4sEWOMOuVFpQSgWamURBzFpILr8TPcrCu3c1Kuai8hECsMLj8/XGdZq6TsWTh7gffE1EgRzncQQmaWeNCJisCEGgzFHU9v6vtcKnUaM+Mi8yf4Ta8f5plftOKYAV8ajCGMXii4bHnrp7UVshzMZ3WZj+Pq7p4xviYZtL8ACvUKLXNP0SqO7BTguznfyfIH+ng68XZzTj8er1a1pvwSabpP8/8Yhgep+3Uwyh8OiKh2yBsmJy+lDgFVt/N5J//llHL0d/xsoF8Yio53CfN46Ye/0FZJ084DRCmv2vKyyRjekbT2qROmxp8JB3GWE+4wV9HXgfg2ljTCy/fh/ynR7cnBKGjs5yaDk/9RwJ9hpjJACmhOq6k5uKfsvgZTuZjwleBPlRsPFOUC/hQNBsoDd8VQe3CQCICiY1WBPIbz7pwSRt3AYMPYI9EZVQBZ8ldIxEorkq+0JEXyb7tDikoMfXD68JiVqs9iD1mxYO+D6PYeZ8aMfyahl+Bx+iVZf1RIEnK3uMubq2FXX1+bzNma4Xv81VRVPstCtTY0ATDJ52ZlfLQICd3INsALXXa4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(83380400001)(186003)(5660300002)(8936002)(8676002)(6486002)(66946007)(966005)(66476007)(26005)(6512007)(9686003)(66556008)(82960400001)(38100700002)(478600001)(41300700001)(6506007)(4001150100001)(6666004)(4326008)(54906003)(2906002)(86362001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLMjH32SXcZpU+kvIZ5BmVAdXK+xtxRH0Yb5ZBlqEokvNOgXqQoJRMpSdqsp?=
 =?us-ascii?Q?h6aW7wX27k27XW9LqvR0mVd9remOAZPr4n9GsL+//MCtZhhE/T+4Bd9E9j5Y?=
 =?us-ascii?Q?HauzvKXolzujsGJnAIIAB0fgnqatmnXLhwQcgzTztwGoD07+H6SpQlxcHw9e?=
 =?us-ascii?Q?+P8yDdvL4extaLR+oVihi5VRDCHsmuWtEMNe17x+FJQngn9SpYsFHVmhZwnz?=
 =?us-ascii?Q?FiIDAW+2XAmRYsuED4lKzaSYil2rM1TsFh4xaLyidnjsoVgxbohB+01NINws?=
 =?us-ascii?Q?0WVcQfxkBZpGuwen4d5xmfbje/0Pp1T7jpayqVuOM6qCsm/9WPQx9/lagGiO?=
 =?us-ascii?Q?wh1fv64N3haN0fkJsteQDUUEoAFxOWbsq3zKU1wtgbQnf/DnvA/Knlyo2I3d?=
 =?us-ascii?Q?4GQRzF4gxFQAlx3QYba0UC5Ht9iC91LsjfA25jYbymqvxSWT5ZrY/DZ1et8M?=
 =?us-ascii?Q?q86z0PNpsku0GFh0IFCrero44ZmfKeO+2g2836mGmYz/9nfxOpzWEGtsDuzd?=
 =?us-ascii?Q?YokoFoJF6m9n61XD+baCZyqKhkAdN3epM21EXp1NbdSw0ARsEcDiok6BVa4c?=
 =?us-ascii?Q?77x7YeQkJI2VRZ7Vde1Iu4niAdW89Cu9wS4fpdIY9C0vsjjuuTKZSgZSm4Xk?=
 =?us-ascii?Q?ceK2qetBy7mvqP2dTlSQEU0gDzx9XHvq3fxHV6d/sH0Khjxv/bVuyK6aP1QJ?=
 =?us-ascii?Q?GfthQVAYyC8Tig9i2DUxLI8aMjgxN+VBr0em3B/AeXKJ9csVxq5i86E7OLvN?=
 =?us-ascii?Q?0XXO4LYrSXV8Q05opkdmWHf7jLZFNwWjfWbqvUvo+BOhZo5AqxX+onBUUyUc?=
 =?us-ascii?Q?WRoVpJpIDYkfviPO2EEr4xqLj2SiEgDyEHZzAUg75NcNeRib5PNBTnb4VDU1?=
 =?us-ascii?Q?4Ug2J+lDWRkzhpG0oPwoOcgjxPGowVYKho8jVDYvrnUwctJe6rPe7aRv7Qjh?=
 =?us-ascii?Q?gqXz1TpP+AIZmm/qLlmbocjImlI02XCQrh5F0hso6x3ACjGwGY7CFxrrfDkl?=
 =?us-ascii?Q?MlvMe3P+Xv8gBkYjMB5pIWopcZPy/4HW7w79ESmD7HPv74gEd3lwS8gWlDEv?=
 =?us-ascii?Q?aINrQRZtnN196Zpe3Ayp4ufgmr5wdGZrnfPntBfRtL0K+Y44ibLlCCZZ/F+q?=
 =?us-ascii?Q?6uvSYDdCTYkrxumY4u1zgWJP+iTj7KqZcgklT3eOHJaBpTieC3uSsTE3vfOX?=
 =?us-ascii?Q?p9zYESGx/wZEGgXEgKYXSxYcZnaVIpeC6wgZuppY0yMhEUhZ7p8tvyMJgJUp?=
 =?us-ascii?Q?ljY575YubsxYm+XL+o5qYPyarcR3r4V0NAYB2eAWg0krx3b3w7yYQ8IDusm6?=
 =?us-ascii?Q?y2yx3rBrIM+ZvKAVOm4YrZPAHtelviFPXLEZLB6izX0tFjJgg00vnPAsLnIy?=
 =?us-ascii?Q?CmaNUU/zMiamJK0U7VaLU/05EpDUFpYRDOP6i0AY5sWLf/PBo5UXZDIAcPEf?=
 =?us-ascii?Q?0kymRCyXGg1AYuwQAKY+XaGLh/K/KqSxLF8yLCmyD+k1C+4q1shCoUgHLdi8?=
 =?us-ascii?Q?8XkrB3aR49NGFvZFeChIqo41aQdOUxSWVFejyZxspK+dNbKyPKG2OZ/w7PFJ?=
 =?us-ascii?Q?OiLiT5WNdc+JqPA14qkbQvpHhwElBrlbNri75SjdqXDBCeflq+080JFEKeWa?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf43e96-07b7-4e41-5ae7-08dadc96175f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 23:10:43.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLTKOlUgHZo9oV7+LIOdJKf59/jeAiANxw/Jkz5bKrecKWGI4xjesMr6/oCuPDDnf3cyNjS9EpXN1UyA8nHITdMDxgFVscwFq2l1+oAjgRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Changes since v1: (thanks Slava!)
> - 3 precusor patches added
>     PCI Class ID added to pci_ids.h
>     Refactoring to change parameters of cxl_send_cmd() to make
>     it suitable for use from the new switch CCI code.
> - Various fixes around error paths and tidying up (see patch 4)
> 
> CXL rev 3.0 introduced the option for a PCI function, intended to sit on an
> upstream port of a CXL switch.  This function provides a mailbox
> interface similar to that seen on CXL type 3 devices. However, the
> command set is mostly different and intended for Fabric management.
> Note however that as we add support for multi headed devices (MHDs)
> a subset of commands will be available on selected MHD type 3 mailboxes.
> (tunnelling DCD commands for example)
> 
> See: CXL rev 3.0
> 7.2.9 Switch Mailbox CCI
> 8.1.13 Switch Malibox CCI Configuration Space Layout
> 8.2.8.6 Switch Mailbox CCI capability 
> 
> It is probably relatively unusual that a typical host of CXL devices
> will have access to the one of these devices, in many cases they will
> be on a port connected to a BMC or similar. There are a few use cases
> where the host might be in charge of the configuration.
> 
> These are very convenient for testing in conjunction with the QEMU
> emulation though so far CXL switch and type 3 emulation is in QEMU
> is not complex enough to make these particular interesting.
> 
> This initial support provides only a few commands but I'm sending it
> out as an RFC to get some input on how we should refactor the CXL core
> code to support these devices that use some of the provide functionality.
> 
> Test wise, there is emulation support on
> http://gitlab.com/jic23/qemu cxl-2022-10-24 branch
> 
> Assumption for now is that the switch CCI function sits alongside
> a CXL USP. A config blob along the lines of:
> 
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=2 \
>  -device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=0,slot=3 \
>  -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0,sn=12345678 \
>  -device cxl-switch-mailbox-cci,bus=root_port0,addr=0.1 \
>  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
>  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7
> 
> should create a switch with a suitable function 1 alongside the switch CCI.
> 
> Test wise, an example using the user space ioctls is given below.
> Longer term this will want to be done with a suitable open source fabric
> manager library / program.
> 
> #include <linux/types.h>
> #include <stdint.h>
> #include <sys/ioctl.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include "cxl_mem.h"
> 
> /* Move to appropriate header later */
> struct cxl_cmd_infostat_identify_rsp {
>   uint16_t pcie_vid;
>   uint16_t pcie_did;
>   uint16_t pcie_subsys_vid;
>   uint16_t pcie_subsys_id;
>   uint64_t sn;
>   uint8_t max_message_size;
>   uint8_t component_type;
> };
> 
> struct cxl_cmd_infostat_get_bg_cmd_sts_rsp { 
>   uint8_t status;
>   uint8_t rsvd;
>   uint16_t opcode;
>   uint16_t returncode;
>   uint16_t vendor_ext_status;
> };
> 
> struct cxl_cmd_identify_switch_device_rsp {
>   uint8_t ingress_port_id;
>   uint8_t rsvd;
>   uint8_t num_physical_ports;
>   uint8_t num_vcs;
>   uint8_t active_port_bm[0x20];
>   uint8_t vcs_bm[0x20];
>   uint16_t total_num_vPPBs;
>   uint16_t num_bound_vPPBs;
>   uint8_t num_hdm_decoders;
> } __attribute__((packed));
> 
> int main()
> {
>   struct cxl_send_command cmd = {};
>   struct cxl_cmd_infostat_identify_rsp is_identify;
>   struct cxl_cmd_identify_switch_device_rsp switch_identify;
>   struct cxl_cmd_infostat_get_bg_cmd_sts_rsp bg_cmd_status;
>   int fd;
>   int rc, i;
> 
>   fd = open("/dev/cxl/swcci0", O_RDWR);
>   if (fd < 0) {
>     printf("could not open file\n");
>     return 0;
>   }
>   cmd.id = CXL_MEM_COMMAND_ID_RAW;

Is the expectation that only "raw" mode operation is needed for this?
That reduces some of the woory since one would need to be running a
debug kernel and a debug utility.

However, if this is going to be a more formal capability then maybe it
wants a sysfs model and the full ABI vetting.


>   cmd.id = CXL_MEM_COMMAND_ID_INFO_STAT_IDENT;
>   cmd.out.size = sizeof(is_identify);
>   cmd.out.payload = (__u64)&is_identify;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc %d\n", rc);
>     if (rc < 0)
>       return rc;
>   }
> 
>   printf("Identify on switch:\n");
>   printf("VID:0x%04x DID:0x%04x\n", is_identify.pcie_vid, is_identify.pcie_did);
>   printf("Subsys: VID:0x%04x DID:0x%04x\n", is_identify.pcie_subsys_vid, is_identify.pcie_subsys_id);
> 
>   cmd.id = CXL_MEM_COMMAND_ID_GET_BG_CMD_STATUS;
>   cmd.out.size = sizeof(bg_cmd_status);
>   cmd.out.payload = (__u64)&bg_cmd_status;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc %d\n", rc);
>     if (rc < 0)
>       return rc;
>   }
> 
>   cmd.id = CXL_MEM_COMMAND_ID_IDENTIFY_SWITCH_DEVICE;
>   cmd.out.size = sizeof(switch_identify);
>   cmd.out.payload = (__u64)&switch_identify;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc %d\n", rc);
>     if (rc < 0)
>       return rc;
>   }
> 
>   printf("Switch indent ingress=%#x #ports=%d\n",
> 	 switch_identify.ingress_port_id,
> 	 switch_identify.num_physical_ports);
>   for (i = 0; i < sizeof(switch_identify.active_port_bm); i++) {
>     int j;
>     for (j = 0; j < 8; j++) {
>       if (switch_identify.active_port_bm[i] & 1 << j) {
> 	printf("Port %x active\n", i * 8 + j);
>       }
>     }
>   }
>   
>   return 0;	 
> }
> 
> Jonathan Cameron (4):
>   cxl/mbox: Use local cxl_device_state variable
>   cxl/mbox: Change paramaters to cxl_send_cmd() to not assume a cxl
>     memory device.
>   PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
>   cxl/pci: Add support for stand alone CXL Switch mailbox CCI
> 
>  drivers/cxl/core/Makefile     |   1 +
>  drivers/cxl/core/core.h       |   6 +-
>  drivers/cxl/core/mbox.c       |  12 ++-
>  drivers/cxl/core/memdev.c     |   4 +-
>  drivers/cxl/core/port.c       |   4 +
>  drivers/cxl/core/switch-cci.c | 149 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h          |   3 +
>  drivers/cxl/cxlpci.h          |   3 +
>  drivers/cxl/cxlswitch.h       |  18 ++++
>  drivers/cxl/pci.c             |  95 +++++++++++++++++++++-
>  include/linux/pci_ids.h       |   1 +
>  include/uapi/linux/cxl_mem.h  |   3 +
>  12 files changed, 292 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/cxl/core/switch-cci.c
>  create mode 100644 drivers/cxl/cxlswitch.h
> 
> -- 
> 2.37.2
> 


