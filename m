Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD9C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 12:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiCaMN4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCaMN4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Mar 2022 08:13:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A820A3AB
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 05:12:08 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KThvR5L4jz686k2;
        Thu, 31 Mar 2022 20:10:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 31 Mar 2022 14:12:05 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 13:12:04 +0100
Date:   Thu, 31 Mar 2022 13:12:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Be?= =?ISO-8859-1?Q?nn=E9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v8 27/46] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Message-ID: <20220331131203.000079cd@huawei.com>
In-Reply-To: <87lewu8cmo.fsf@pond.sub.org>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-28-Jonathan.Cameron@huawei.com>
        <87lewu8cmo.fsf@pond.sub.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 28 Mar 2022 14:50:23 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
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
> > -cxl-fixed-memory-window targets.0=cxl.0,size=128G
> > -cxl-fixed-memory-window targets.0=cxl.1,size=128G
> > -cxl-fixed-memory-window targets.0=cxl0,targets.1=cxl.1,size=256G,interleave-granularity=2k
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

Agree with everything you've raised.  Thanks!

Jonathan

> 
> [...]
> 
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 42fc68403d..e4e64096ca 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -504,6 +504,24 @@
> >     'dst': 'uint16',
> >     'val': 'uint8' }}
> >  
> > +##
> > +# @CXLFixedMemoryWindowOptions:
> > +#
> > +# Create a CXL Fixed Memory Window (for OptsVisitor)  
> 
> Please drop "(for OptsVisitor)".  It's no longer true.
> 

Done

> Aside: I'd ask to drop it even if it was true, because it's about an
> implementation detail.  Such details don't belong in doc comments, which
> become QMP *user* documentation.  I know we have the same parenthesis
> elsewhere.  It should be dropped there as well, but that's not this
> series' problem.
> 
> > +#
> > +# @size: Size in bytes of the Fixed Memory Window  
> 
> I'm not a native speaker, but "Size of the fixed memory window in bytes"
> sounds better to me.
Done.
> 
> Are arbitrary sizes accepted?

Good point - no.  Multiple of 256MiB. Added
"Must be a multiple of 256MiB."

For interleave-granularity I've listed the possible values out as
"Accepted values [256, 512, 1k, 2k, 4k, 8k, 16k]"

> 
> > +# @interleave-granularity: Number of contiguous bytes for which
> > +#                          accesses will go to a given interleave target.
> > +# @targets: Target root bridge IDs  
> 
> What kind of IDs are these?  Hmm, the CLI help text below suggest qdev
> IDs (the ones in -device id=...).  Correct?

Yes. I've added "from -device ...,id=<ID> for each root bridge."
That leaves room for other root bridge implementations than pxb-cxl
in future without having to update this text.

> 
> > +#
> > +# Since 6.3  
> 
> 7.1 most likely.

Updated.

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
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 58f2f76775..764f57606d 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -467,6 +467,44 @@ SRST
> >          -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
> >  ERST
> >  
> > +DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
> > +    "-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]\n",
> > +    QEMU_ARCH_ALL)
> > +SRST
> > +``-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]``
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
> > +    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
> > +    which may be identified by the id provied in the -device entry.
> > +    Multiple entries are needed to specify all the targets when
> > +    the fixed memory window represents interleaved memory. X is the
> > +    target index from 0.
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
> > +        -cxl-fixed-memory-window -targets.0=cxl.0,-targets.1=cxl.1,size=128G,interleave-granularity=512k
> > +
> > +ERST
> > +
> >  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
> >      "-add-fd fd=fd,set=set[,opaque=opaque]\n"
> >      "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index 0b81f61535..dab1eb3380 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -92,6 +92,7 @@
> >  #include "qemu/config-file.h"
> >  #include "qemu/qemu-options.h"
> >  #include "qemu/main-loop.h"
> > +#include "hw/cxl/cxl.h"
> >  #ifdef CONFIG_VIRTFS
> >  #include "fsdev/qemu-fsdev.h"
> >  #endif
> > @@ -117,6 +118,7 @@
> >  #include "qapi/qapi-events-run-state.h"
> >  #include "qapi/qapi-visit-block-core.h"
> >  #include "qapi/qapi-visit-compat.h"
> > +#include "qapi/qapi-visit-machine.h"
> >  #include "qapi/qapi-visit-ui.h"
> >  #include "qapi/qapi-commands-block-core.h"
> >  #include "qapi/qapi-commands-migration.h"
> > @@ -140,6 +142,11 @@ typedef struct BlockdevOptionsQueueEntry {
> >  
> >  typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
> >  
> > +typedef struct CXLFMWOptionQueueEntry {
> > +    CXLFixedMemoryWindowOptions *opts;
> > +    QSIMPLEQ_ENTRY(CXLFMWOptionQueueEntry) entry;
> > +} CXLFMWOptionQueueEntry;
> > +
> >  typedef struct ObjectOption {
> >      ObjectOptions *opts;
> >      QTAILQ_ENTRY(ObjectOption) next;
> > @@ -166,6 +173,8 @@ static int snapshot;
> >  static bool preconfig_requested;
> >  static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
> >  static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
> > +static QSIMPLEQ_HEAD(, CXLFMWOptionQueueEntry) CXLFMW_opts =
> > +    QSIMPLEQ_HEAD_INITIALIZER(CXLFMW_opts);
> >  static bool nographic = false;
> >  static int mem_prealloc; /* force preallocation of physical target memory */
> >  static ram_addr_t ram_size;
> > @@ -1149,6 +1158,23 @@ static void parse_display(const char *p)
> >      }
> >  }
> >  
> > +static void parse_cxl_fixed_memory_window(const char *optarg)
> > +{
> > +    CXLFMWOptionQueueEntry *cfmws_entry;
> > +    Visitor *v;
> > +
> > +    v = qobject_input_visitor_new_str(optarg, "cxl-fixed-memory-window",
> > +                                      &error_fatal);
> > +    cfmws_entry = g_new(CXLFMWOptionQueueEntry, 1);
> > +    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &cfmws_entry->opts,
> > +                                           &error_fatal);
> > +    if (!cfmws_entry->opts) {
> > +        exit(1);
> > +    }
> > +    visit_free(v);  
> 
> If you loc_save() here like we do for QEMU_OPTION_blockdev, and ...
> 
> > +    QSIMPLEQ_INSERT_TAIL(&CXLFMW_opts, cfmws_entry, entry);
> > +}
> > +
> >  static inline bool nonempty_str(const char *str)
> >  {
> >      return str && *str;
> > @@ -2020,6 +2046,19 @@ static void qemu_create_late_backends(void)
> >      qemu_semihosting_console_init();
> >  }
> >  
> > +static void cxl_set_opts(void)
> > +{
> > +    while (!QSIMPLEQ_EMPTY(&CXLFMW_opts)) {
> > +        CXLFMWOptionQueueEntry *cfmws_entry = QSIMPLEQ_FIRST(&CXLFMW_opts);
> > +
> > +        QSIMPLEQ_REMOVE_HEAD(&CXLFMW_opts, entry);  
> 
> ... loc_pop() here, like we do in configure_blockdev(), then the error
> messages from cxl_fixed_memory_window_options_set() will point to the
> offending option, which is nice.  Give it a try, please.

Nice :)

> 
> > +        cxl_fixed_memory_window_options_set(current_machine, cfmws_entry->opts,  
> 
> Line is a bit long.  Name the function cxl_fixed_memory_window_config()?
Done


> 
> > +                                            &error_fatal);
> > +        qapi_free_CXLFixedMemoryWindowOptions(cfmws_entry->opts);
> > +        g_free(cfmws_entry);
> > +    }
> > +}
> > +
> >  static bool have_custom_ram_size(void)
> >  {
> >      QemuOpts *opts = qemu_find_opts_singleton("memory");
> > @@ -2745,6 +2784,7 @@ void qmp_x_exit_preconfig(Error **errp)
> >  
> >      qemu_init_board();
> >      qemu_create_cli_devices();
> > +    cxl_fixed_memory_window_link_targets(errp);
> >      qemu_machine_creation_done();
> >  
> >      if (loadvm) {
> > @@ -2925,6 +2965,9 @@ void qemu_init(int argc, char **argv, char **envp)
> >                      exit(1);
> >                  }
> >                  break;
> > +            case QEMU_OPTION_cxl_fixed_memory_window:
> > +                parse_cxl_fixed_memory_window(optarg);
> > +                break;
> >              case QEMU_OPTION_display:
> >                  parse_display(optarg);
> >                  break;
> > @@ -3762,6 +3805,7 @@ void qemu_init(int argc, char **argv, char **envp)
> >  
> >      qemu_resolve_machine_memdev();
> >      parse_numa_opts(current_machine);
> > +    cxl_set_opts();
> >  
> >      if (vmstate_dump_file) {
> >          /* dump and exit */  
> 

