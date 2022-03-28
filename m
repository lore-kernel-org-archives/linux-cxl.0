Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E62C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 28 Mar 2022 12:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiC1MwN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Mar 2022 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiC1MwM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Mar 2022 08:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D63583ED3E
        for <linux-cxl@vger.kernel.org>; Mon, 28 Mar 2022 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648471829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bvXDs+l0A2SKHz7hugoRuVWnXSa+lRqz+nHgyJXrdo=;
        b=QzNMmqPuM0lV8llvXZxgMczxiXD+Oan891fFsDaAfo8CRHBPWkZi0Fip7Vx7BDrEEi/2QZ
        h7Gvy3vapCX63mlH7sHpNvbgj3G7Gb7CCP3hCMw7cvLUVk21bQR53yRl4zQNf3fFfHIr1Y
        ZvFQbwPI/vu9auz7yTCofvDiYQMXq+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-0DcXpvmWMWyghCFpfLpF6Q-1; Mon, 28 Mar 2022 08:50:27 -0400
X-MC-Unique: 0DcXpvmWMWyghCFpfLpF6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BEAC100BAAD;
        Mon, 28 Mar 2022 12:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66B2940C1257;
        Mon, 28 Mar 2022 12:50:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 42D9E21E691D; Mon, 28 Mar 2022 14:50:23 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= 
        <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>,
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
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-28-Jonathan.Cameron@huawei.com>
Date:   Mon, 28 Mar 2022 14:50:23 +0200
In-Reply-To: <20220318150635.24600-28-Jonathan.Cameron@huawei.com> (Jonathan
        Cameron's message of "Fri, 18 Mar 2022 15:06:16 +0000")
Message-ID: <87lewu8cmo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> The concept of these is introduced in [1] in terms of the
> description the CEDT ACPI table. The principal is more general.
> Unlike once traffic hits the CXL root bridges, the host system
> memory address routing is implementation defined and effectively
> static once observable by standard / generic system software.
> Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> which has fixed system dependent routing configured so that
> accesses can be routed to the CXL devices below a set of target
> root bridges. The accesses may be interleaved across multiple
> root bridges.
>
> For QEMU we could have fully specified these regions in terms
> of a base PA + size, but as the absolute address does not matter
> it is simpler to let individual platforms place the memory regions.
>
> ExampleS:
> -cxl-fixed-memory-window targets.0=cxl.0,size=128G
> -cxl-fixed-memory-window targets.0=cxl.1,size=128G
> -cxl-fixed-memory-window targets.0=cxl0,targets.1=cxl.1,size=256G,interleave-granularity=2k
>
> Specifies
> * 2x 128G regions not interleaved across root bridges, one for each of
>   the root bridges with ids cxl.0 and cxl.1
> * 256G region interleaved across root bridges with ids cxl.0 and cxl.1
> with a 2k interleave granularity.
>
> When system software enumerates the devices below a given root bridge
> it can then decide which CFMW to use. If non interleave is desired
> (or possible) it can use the appropriate CFMW for the root bridge in
> question.  If there are suitable devices to interleave across the
> two root bridges then it may use the 3rd CFMS.
>
> A number of other designs were considered but the following constraints
> made it hard to adapt existing QEMU approaches to this particular problem.
> 1) The size must be known before a specific architecture / board brings
>    up it's PA memory map.  We need to set up an appropriate region.
> 2) Using links to the host bridges provides a clean command line interface
>    but these links cannot be established until command line devices have
>    been added.
>
> Hence the two step process used here of first establishing the size,
> interleave-ways and granularity + caching the ids of the host bridges
> and then, once available finding the actual host bridges so they can
> be used later to support interleave decoding.
>
> [1] CXL 2.0 ECN: CEDT CFMWS & QTG DSM (computeexpresslink.org / specifications)
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 42fc68403d..e4e64096ca 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -504,6 +504,24 @@
>     'dst': 'uint16',
>     'val': 'uint8' }}
>  
> +##
> +# @CXLFixedMemoryWindowOptions:
> +#
> +# Create a CXL Fixed Memory Window (for OptsVisitor)

Please drop "(for OptsVisitor)".  It's no longer true.

Aside: I'd ask to drop it even if it was true, because it's about an
implementation detail.  Such details don't belong in doc comments, which
become QMP *user* documentation.  I know we have the same parenthesis
elsewhere.  It should be dropped there as well, but that's not this
series' problem.

> +#
> +# @size: Size in bytes of the Fixed Memory Window

I'm not a native speaker, but "Size of the fixed memory window in bytes"
sounds better to me.

Are arbitrary sizes accepted?

> +# @interleave-granularity: Number of contiguous bytes for which
> +#                          accesses will go to a given interleave target.
> +# @targets: Target root bridge IDs

What kind of IDs are these?  Hmm, the CLI help text below suggest qdev
IDs (the ones in -device id=...).  Correct?

> +#
> +# Since 6.3

7.1 most likely.

> +##
> +{ 'struct': 'CXLFixedMemoryWindowOptions',
> +  'data': {
> +      'size': 'size',
> +      '*interleave-granularity': 'size',
> +      'targets': ['str'] }}
> +
>  ##
>  # @X86CPURegister32:
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 58f2f76775..764f57606d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -467,6 +467,44 @@ SRST
>          -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
>  ERST
>  
> +DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
> +    "-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]``
> +    Define a CXL Fixed Memory Window (CFMW).
> +
> +    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
> +
> +    They are regions of Host Physical Addresses (HPA) on a system which
> +    may be interleaved across one or more CXL host bridges.  The system
> +    software will assign particular devices into these windows and
> +    configure the downstream Host-managed Device Memory (HDM) decoders
> +    in root ports, switch ports and devices appropriately to meet the
> +    interleave requirements before enabling the memory devices.
> +
> +    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
> +    which may be identified by the id provied in the -device entry.
> +    Multiple entries are needed to specify all the targets when
> +    the fixed memory window represents interleaved memory. X is the
> +    target index from 0.
> +
> +    ``size=size`` sets the size of the CFMW. This must be a multiple of
> +    256MiB. The region will be aligned to 256MiB but the location is
> +    platform and configuration dependent.
> +
> +    ``interleave-granularity=granularity`` sets the granularity of
> +    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
> +    4096KiB, 8192KiB and 16384KiB granularities supported.
> +
> +    Example:
> +
> +    ::
> +
> +        -cxl-fixed-memory-window -targets.0=cxl.0,-targets.1=cxl.1,size=128G,interleave-granularity=512k
> +
> +ERST
> +
>  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
>      "-add-fd fd=fd,set=set[,opaque=opaque]\n"
>      "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 0b81f61535..dab1eb3380 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -92,6 +92,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/qemu-options.h"
>  #include "qemu/main-loop.h"
> +#include "hw/cxl/cxl.h"
>  #ifdef CONFIG_VIRTFS
>  #include "fsdev/qemu-fsdev.h"
>  #endif
> @@ -117,6 +118,7 @@
>  #include "qapi/qapi-events-run-state.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qapi-visit-compat.h"
> +#include "qapi/qapi-visit-machine.h"
>  #include "qapi/qapi-visit-ui.h"
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-commands-migration.h"
> @@ -140,6 +142,11 @@ typedef struct BlockdevOptionsQueueEntry {
>  
>  typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
>  
> +typedef struct CXLFMWOptionQueueEntry {
> +    CXLFixedMemoryWindowOptions *opts;
> +    QSIMPLEQ_ENTRY(CXLFMWOptionQueueEntry) entry;
> +} CXLFMWOptionQueueEntry;
> +
>  typedef struct ObjectOption {
>      ObjectOptions *opts;
>      QTAILQ_ENTRY(ObjectOption) next;
> @@ -166,6 +173,8 @@ static int snapshot;
>  static bool preconfig_requested;
>  static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>  static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
> +static QSIMPLEQ_HEAD(, CXLFMWOptionQueueEntry) CXLFMW_opts =
> +    QSIMPLEQ_HEAD_INITIALIZER(CXLFMW_opts);
>  static bool nographic = false;
>  static int mem_prealloc; /* force preallocation of physical target memory */
>  static ram_addr_t ram_size;
> @@ -1149,6 +1158,23 @@ static void parse_display(const char *p)
>      }
>  }
>  
> +static void parse_cxl_fixed_memory_window(const char *optarg)
> +{
> +    CXLFMWOptionQueueEntry *cfmws_entry;
> +    Visitor *v;
> +
> +    v = qobject_input_visitor_new_str(optarg, "cxl-fixed-memory-window",
> +                                      &error_fatal);
> +    cfmws_entry = g_new(CXLFMWOptionQueueEntry, 1);
> +    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &cfmws_entry->opts,
> +                                           &error_fatal);
> +    if (!cfmws_entry->opts) {
> +        exit(1);
> +    }
> +    visit_free(v);

If you loc_save() here like we do for QEMU_OPTION_blockdev, and ...

> +    QSIMPLEQ_INSERT_TAIL(&CXLFMW_opts, cfmws_entry, entry);
> +}
> +
>  static inline bool nonempty_str(const char *str)
>  {
>      return str && *str;
> @@ -2020,6 +2046,19 @@ static void qemu_create_late_backends(void)
>      qemu_semihosting_console_init();
>  }
>  
> +static void cxl_set_opts(void)
> +{
> +    while (!QSIMPLEQ_EMPTY(&CXLFMW_opts)) {
> +        CXLFMWOptionQueueEntry *cfmws_entry = QSIMPLEQ_FIRST(&CXLFMW_opts);
> +
> +        QSIMPLEQ_REMOVE_HEAD(&CXLFMW_opts, entry);

... loc_pop() here, like we do in configure_blockdev(), then the error
messages from cxl_fixed_memory_window_options_set() will point to the
offending option, which is nice.  Give it a try, please.

> +        cxl_fixed_memory_window_options_set(current_machine, cfmws_entry->opts,

Line is a bit long.  Name the function cxl_fixed_memory_window_config()?

> +                                            &error_fatal);
> +        qapi_free_CXLFixedMemoryWindowOptions(cfmws_entry->opts);
> +        g_free(cfmws_entry);
> +    }
> +}
> +
>  static bool have_custom_ram_size(void)
>  {
>      QemuOpts *opts = qemu_find_opts_singleton("memory");
> @@ -2745,6 +2784,7 @@ void qmp_x_exit_preconfig(Error **errp)
>  
>      qemu_init_board();
>      qemu_create_cli_devices();
> +    cxl_fixed_memory_window_link_targets(errp);
>      qemu_machine_creation_done();
>  
>      if (loadvm) {
> @@ -2925,6 +2965,9 @@ void qemu_init(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>                  break;
> +            case QEMU_OPTION_cxl_fixed_memory_window:
> +                parse_cxl_fixed_memory_window(optarg);
> +                break;
>              case QEMU_OPTION_display:
>                  parse_display(optarg);
>                  break;
> @@ -3762,6 +3805,7 @@ void qemu_init(int argc, char **argv, char **envp)
>  
>      qemu_resolve_machine_memdev();
>      parse_numa_opts(current_machine);
> +    cxl_set_opts();
>  
>      if (vmstate_dump_file) {
>          /* dump and exit */

