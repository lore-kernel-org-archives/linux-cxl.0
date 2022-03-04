Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF79C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Mar 2022 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiCDP5d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiCDP5c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Mar 2022 10:57:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB11C6EEC
        for <linux-cxl@vger.kernel.org>; Fri,  4 Mar 2022 07:56:43 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K9C9p1Yllz67YS6;
        Fri,  4 Mar 2022 23:55:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 16:56:41 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 15:56:40 +0000
Date:   Fri, 4 Mar 2022 15:56:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn?= =?ISO-8859-1?Q?=E9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 27/43] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Message-ID: <20220304155638.00007bae@huawei.com>
In-Reply-To: <87y21slu6m.fsf@pond.sub.org>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
        <20220211120747.3074-28-Jonathan.Cameron@huawei.com>
        <87y21slu6m.fsf@pond.sub.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Mar 2022 07:55:45 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron via <qemu-devel@nongnu.org> writes:
> 
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >
> > The concept of these is introduced in [1] in terms of the
> > description the CEDT ACPI table. The principal is more general.
> > Unlike once traffic hits the CXL root bridges, the host system
> > memory address routing is implementation defined and effectively
> > static once observable by standard / generic system software.
> > Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> > which has fixed system dependent routing configured so that
> > accesses can be routed to the CXL devices below a set of target
> > root bridges. The accesses may be interleaved across multiple
> > root bridges.
> >
> > For QEMU we could have fully specified these regions in terms
> > of a base PA + size, but as the absolute address does not matter
> > it is simpler to let individual platforms place the memory regions.
> >
> > ExampleS:
> > -cxl-fixed-memory-window targets=cxl.0,size=128G
> > -cxl-fixed-memory-window targets=cxl.1,size=128G
> > -cxl-fixed-memory-window targets=cxl0,targets=cxl.1,size=256G,interleave-granularity=2k
> >
> > Specifies
> > * 2x 128G regions not interleaved across root bridges, one for each of
> >   the root bridges with ids cxl.0 and cxl.1
> > * 256G region interleaved across root bridges with ids cxl.0 and cxl.1
> > with a 2k interleave granularity.
> >
> > When system software enumerates the devices below a given root bridge
> > it can then decide which CFMW to use. If non interleave is desired
> > (or possible) it can use the appropriate CFMW for the root bridge in
> > question.  If there are suitable devices to interleave across the
> > two root bridges then it may use the 3rd CFMS.
> >
> > A number of other designs were considered but the following constraints
> > made it hard to adapt existing QEMU approaches to this particular problem.
> > 1) The size must be known before a specific architecture / board brings
> >    up it's PA memory map.  We need to set up an appropriate region.
> > 2) Using links to the host bridges provides a clean command line interface
> >    but these links cannot be established until command line devices have
> >    been added.
> >
> > Hence the two step process used here of first establishing the size,
> > interleave-ways and granularity + caching the ids of the host bridges
> > and then, once available finding the actual host bridges so they can
> > be used later to support interleave decoding.
> >
> > [1] CXL 2.0 ECN: CEDT CFMWS & QTG DSM (computeexpresslink.org / specifications)
> >
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>  
> 
> [...]
> 
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > new file mode 100644
> > index 0000000000..9f303e6d8e
> > --- /dev/null
> > +++ b/hw/cxl/cxl-host.c  
> 
> [...]
> 
> > +QemuOptsList qemu_cxl_fixed_window_opts = {
> > +    .name = "cxl-fixed-memory-window",
> > +    .implied_opt_name = "type",
> > +    .head = QTAILQ_HEAD_INITIALIZER(qemu_cxl_fixed_window_opts.head),
> > +    .desc = { { 0 } }
> > +};
> > +  
> 
> [...]
> 
> > +static int parse_cxl_fixed_memory_window(void *opaque, QemuOpts *opts,
> > +                                         Error **errp)
> > +{
> > +    CXLFixedMemoryWindowOptions *object = NULL;
> > +    MachineState *ms = MACHINE(opaque);
> > +    Error *err = NULL;
> > +    Visitor *v = opts_visitor_new(opts);
> > +
> > +    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &object, errp);
> > +    visit_free(v);
> > +    if (!object) {
> > +        return -1;
> > +    }
> > +
> > +    set_cxl_fixed_memory_window_options(ms, object, &err);
> > +
> > +    qapi_free_CXLFixedMemoryWindowOptions(object);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +void parse_cxl_fixed_memory_window_opts(MachineState *ms)
> > +{
> > +    qemu_opts_foreach(qemu_find_opts("cxl-fixed-memory-window"),
> > +                      parse_cxl_fixed_memory_window, ms, &error_fatal);
> > +}  
> 
> [...]
> 
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 42fc68403d..0998a9128d 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -504,6 +504,21 @@
> >     'dst': 'uint16',
> >     'val': 'uint8' }}
> >  
> > +##
> > +# @CXLFixedMemoryWindowOptions:
> > +#
> > +# Create a CXL Fixed Memory Window (for OptsVisitor)
> > +#
> > +# @targets: Target root bridge IDs  
> 
> Missing: @size, @targets.
> 
> > +#
> > +# Since X.X //fixme  
> 
> Well, "fix me, please".
> 
> > +##
> > +{ 'struct': 'CXLFixedMemoryWindowOptions',
> > +  'data': {
> > +      'size': 'size',
> > +      '*interleave-granularity': 'size',
> > +      'targets': ['str'] }}
> > +
> >  ##
> >  # @X86CPURegister32:
> >  #  
> 
> [...]
> 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ba3ae6a42a..b4d2cc6f48 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -467,6 +467,43 @@ SRST
> >          -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
> >  ERST
> >  
> > +DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
> > +    "-cxl-fixed-memory-window targets=firsttarget,targets=secondtarget,size=size[,interleave-granularity=granularity]\n",
> > +    QEMU_ARCH_ALL)
> > +SRST
> > +``-cxl-fixed-memory-window targets=firsttarget,targets=secondtarget,size=size[,interleave-granularity=granularity]``
> > +    Define a CXL Fixed Memory Window (CFMW).
> > +
> > +    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
> > +
> > +    They are regions of Host Physical Addresses (HPA) on a system which
> > +    may be interleaved across one or more CXL host bridges.  The system
> > +    software will assign particular devices into these windows and
> > +    configure the downstream Host-managed Device Memory (HDM) decoders
> > +    in root ports, switch ports and devices appropriately to meet the
> > +    interleave requirements before enabling the memory devices.
> > +
> > +    ``targets=firsttarget`` provides the mapping to CXL host bridges
> > +    which may be identified by the id provied in the -device entry.
> > +    Multiple entries are needed to specify all the targets when
> > +    the fixed memory window represents interleaved memory.
> > +
> > +    ``size=size`` sets the size of the CFMW. This must be a multiple of
> > +    256MiB. The region will be aligned to 256MiB but the location is
> > +    platform and configuration dependent.
> > +
> > +    ``interleave-granularity=granularity`` sets the granularity of
> > +    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
> > +    4096KiB, 8192KiB and 16384KiB granularities supported.
> > +
> > +    Example:
> > +
> > +    ::
> > +
> > +        -cxl-fixed-memory-window -targets=cxl.0,-targets=cxl.1,size=128G,interleave-granularity=512k
> > +
> > +ERST
> > +
> >  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
> >      "-add-fd fd=fd,set=set[,opaque=opaque]\n"
> >      "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index 5e1b35ba48..f83f158fff 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -91,6 +91,7 @@
> >  #include "qemu/config-file.h"
> >  #include "qemu/qemu-options.h"
> >  #include "qemu/main-loop.h"
> > +#include "hw/cxl/cxl.h"
> >  #ifdef CONFIG_VIRTFS
> >  #include "fsdev/qemu-fsdev.h"
> >  #endif
> > @@ -2744,6 +2745,7 @@ void qmp_x_exit_preconfig(Error **errp)
> >  
> >      qemu_init_board();
> >      qemu_create_cli_devices();
> > +    cxl_fixed_memory_window_link_targets(errp);
> >      qemu_machine_creation_done();
> >  
> >      if (loadvm) {
> > @@ -2805,6 +2807,7 @@ void qemu_init(int argc, char **argv, char **envp)
> >      qemu_add_opts(&qemu_msg_opts);
> >      qemu_add_opts(&qemu_name_opts);
> >      qemu_add_opts(&qemu_numa_opts);
> > +    qemu_add_opts(&qemu_cxl_fixed_window_opts);
> >      qemu_add_opts(&qemu_icount_opts);
> >      qemu_add_opts(&qemu_semihosting_config_opts);
> >      qemu_add_opts(&qemu_fw_cfg_opts);
> > @@ -2927,6 +2930,13 @@ void qemu_init(int argc, char **argv, char **envp)
> >                      exit(1);
> >                  }
> >                  break;
> > +            case QEMU_OPTION_cxl_fixed_memory_window:
> > +                opts = qemu_opts_parse_noisily(qemu_find_opts("cxl-fixed-memory-window"),
> > +                                               optarg, true);
> > +                if (!opts) {
> > +                    exit(1);
> > +                }
> > +                break;
> >              case QEMU_OPTION_display:
> >                  parse_display(optarg);
> >                  break;
> > @@ -3764,6 +3774,7 @@ void qemu_init(int argc, char **argv, char **envp)
> >  
> >      qemu_resolve_machine_memdev();
> >      parse_numa_opts(current_machine);
> > +    parse_cxl_fixed_memory_window_opts(current_machine);
> >  
> >      if (vmstate_dump_file) {
> >          /* dump and exit */  
> 
> Have you considered using qobject_input_visitor_new_str() instead of
> QemuOpts?
> 

Umm. No. Why might that be a better approach?

Thanks,

Jonathan


