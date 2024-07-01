Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EE8405D
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823948; cv=none; b=n/wKaWF8ki2KGSGt9pxYx5hKi2GAZDyxk9I3NyvdFc0WKCMUc8IYs98480YpVPTTls6UhUZHM0Vj5WBl44LqXwuBKkiH+TVF/pOY03gm9mVZmCBKZk2JXTqYfMWg9nofcuNeGAg4xsuJ9bSMhr5h3ULmS5/KjhYsAoMaQknCcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823948; c=relaxed/simple;
	bh=i+wTLxo8goxmshI3NJSMjnDdCekKxNfvmMCwtZRqzCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSxptqNdNO0kVHS6fGXTNkCQJzDumlemIra9aU5ZgGkvwMIsfrsR+lO/m+D4WMqJy9cMe9ajyzM70ZOXChf/bJOrB5GULQ/G9mbYrjp9bapOvjk0qprSt3xAnt//m6FD/gVnKxjWIAs8JyppKoIATir8zJ9RLdQ+UN+8Rbt+iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3RTu3ZM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3RTu3ZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRVEDXTdNlFKmz4YCovzLKk9fuFunRyAXDljDw8v6w0=;
	b=Y3RTu3ZMUZXntPe6bejBU7y2ePV99xubor9gXX6HwizK7UipqjrUUd1KFHqCzFaibwHbNN
	JZatXeIq06IMA3hXEddtDBLkbIrT2iYEoCdhemYBDRIREc3BdmUcAQ7FVpoGjZnJeZGSE5
	/Z1iltZezLhKpn8yTFj7NmM5wB6Ngy8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-QfX8SZS5OC-Cyjr2XtF4Bg-1; Mon, 01 Jul 2024 04:52:23 -0400
X-MC-Unique: QfX8SZS5OC-Cyjr2XtF4Bg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52cdd8ca5a8so2632755e87.3
        for <linux-cxl@vger.kernel.org>; Mon, 01 Jul 2024 01:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823941; x=1720428741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRVEDXTdNlFKmz4YCovzLKk9fuFunRyAXDljDw8v6w0=;
        b=BR2gM4Hff3Lfsm5w0hW6Ikx2LPjjisBnjnRQbs8yEq14hmzvAHcqprWPJ3VT+JLWGz
         i4Vt9ANpkUxPFjPQq+SYll6riYTRFswRNQ5hWvJ6vbToyRAr2U4NZJo0f5khISkrDElV
         /oyClRWlEY6cqDcRZUMzJnCac7Lnb9c++oRdyY2+Nr+Ye+cEBmLA42IXEYqrveXr3nqf
         sUdnAEBsBplEEZwg6v2wHe4zypUN50rXIDNjhuAwPTrOOtDkRwBak2ffsofI2/Bf30K8
         B8I5ElBi8mqC4hPy2hkJirk2DPyxAbsJcCCcmwnh6tcv5LYh53bprKcuoH5h48XARKNq
         omhA==
X-Forwarded-Encrypted: i=1; AJvYcCX9L8H1kWnmkOCZAaCJdwJMPxGMH8esIJmerzHpeQsZg8ayl/7clMXbMDbYwn3MgBHH3ytBswzYJW7iG2TkTCkgFqTLWfwhRH7x
X-Gm-Message-State: AOJu0YyvjzIB0Vpl4L/ueVOeO3xqxDFeM4qIF3NwjydjIkIxNVOY01JB
	Y57cjdiAZWzsto7875ZFWPlm7YuwKRdgIl8rScjIGXW4Qwhj+HMXEkUk/tW6vC1gIc+GEm1+GDp
	Ia+3JzK0eOjGtO5Q/6WDKbpcgaDz+obOkH6tAfQJ4gTxzYnjLSCv8qTmR34YiZ302nw==
X-Received: by 2002:a05:6512:2203:b0:52c:dbd9:45e7 with SMTP id 2adb3069b0e04-52e82733f0emr2984136e87.57.1719823941544;
        Mon, 01 Jul 2024 01:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmKCiyhziEd0xSgbRZFS60ruI6lPbmiK/Gnw6f0eVwYH4U9u4JUF4X8S0UoKuI3DY82Jhcnw==
X-Received: by 2002:a05:6512:2203:b0:52c:dbd9:45e7 with SMTP id 2adb3069b0e04-52e82733f0emr2984121e87.57.1719823941075;
        Mon, 01 Jul 2024 01:52:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8df0sm9449780f8f.29.2024.07.01.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:52:20 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:52:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 08/11] hw/acpi: Generic Port Affinity Structure
 support
Message-ID: <20240701105219.09f2b1fd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-9-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-9-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 17:03:16 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> These are very similar to the recently added Generic Initiators
> but instead of representing an initiator of memory traffic they
> represent an edge point beyond which may lie either targets or
> initiators.  Here we add these ports such that they may
> be targets of hmat_lb records to describe the latency and
> bandwidth from host side initiators to the port.  A discoverable
> mechanism such as UEFI CDAT read from CXL devices and switches
> is used to discover the remainder of the path, and the OS can build
> up full latency and bandwidth numbers as need for work and data
> placement decisions.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Move to hw/acpi/pci.c
>     Rename the funciton to actually registers both types
>     of generic nodes to reflect it isn't GI only.
>     Note that the qom part is unchanged and other changes are mostly
>     code movement so I've kept Markus' Ack.
> ---
>  qapi/qom.json                            |  34 ++++
>  include/hw/acpi/acpi_generic_initiator.h |  35 ++++
>  include/hw/acpi/aml-build.h              |   4 +
>  include/hw/acpi/pci.h                    |   3 +-
>  include/hw/pci/pci_bridge.h              |   1 +
>  hw/acpi/acpi_generic_initiator.c         | 216 +++++++++++++++++++++++
>  hw/acpi/aml-build.c                      |  40 +++++
>  hw/acpi/pci.c                            | 110 +++++++++++-
>  hw/arm/virt-acpi-build.c                 |   2 +-
>  hw/i386/acpi-build.c                     |   2 +-
>  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>  11 files changed, 443 insertions(+), 5 deletions(-)

this is quite large patch, is it possible to split into
a set of smaller patches?

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..8fa6bbd9a7 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -826,6 +826,38 @@
>    'data': { 'pci-dev': 'str',
>              'node': 'uint32' } }
>  
> +##
> +# @AcpiGenericPortProperties:
> +#
> +# Properties for acpi-generic-port objects.
> +#
> +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> +#     this SRAT Generic Port Affinity Structure.  This is the same as
> +#     the bus parameter for the root ports attached to this host
> +#     bridge.  The resulting SRAT Generic Port Affinity Structure will
> +#     refer to the ACPI object in DSDT that represents the host bridge
> +#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
> +#     5.2.16.7 for more information.
> +#
> +# @node: Similar to a NUMA node ID, but instead of providing a
> +#     reference point used for defining NUMA distances and access
> +#     characteristics to memory or from an initiator (e.g. CPU), this
> +#     node defines the boundary point between non-discoverable system
> +#     buses which must be described by firmware, and a discoverable
> +#     bus.  NUMA distances and access characteristics are defined to
> +#     and from that point.  For system software to establish full
> +#     initiator to target characteristics this information must be
> +#     combined with information retrieved from the discoverable part
> +#     of the path.  An example would use CDAT (see UEFI.org)
> +#     information read from devices and switches in conjunction with
> +#     link characteristics read from PCIe Configuration space.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'AcpiGenericPortProperties',
> +  'data': { 'pci-bus': 'str',
> +            'node': 'uint32' } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -1019,6 +1051,7 @@
>  { 'enum': 'ObjectType',
>    'data': [
>      'acpi-generic-initiator',
> +    'acpi-generic-port',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -1092,6 +1125,7 @@
>    'discriminator': 'qom-type',
>    'data': {
>        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'acpi-generic-port':          'AcpiGenericPortProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> new file mode 100644
> index 0000000000..92a39ad303
> --- /dev/null
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#ifndef ACPI_GENERIC_INITIATOR_H
> +#define ACPI_GENERIC_INITIATOR_H
> +
> +#include "qom/object_interfaces.h"
> +
> +#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> +
> +typedef struct AcpiGenericInitiator {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *pci_dev;
> +    uint16_t node;
> +} AcpiGenericInitiator;
> +
> +#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
> +
> +typedef struct AcpiGenericPort {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *pci_bus;
> +    uint16_t node;
> +} AcpiGenericPort;
> +
> +void build_srat_generic_pci_initiator(GArray *table_data);
> +
> +#endif
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 9ba3a21c13..fb8cf6c415 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -490,6 +490,10 @@ void build_srat_pci_generic_initiator(GArray *table_date, int node,
>                                        uint16_t segment, uint8_t bus,
>                                        uint8_t devfn);
>  
> +void build_srat_acpi_generic_port(GArray *table_data, int node,
> +                                  const char *hid,
> +                                  uint32_t uid);
> +
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                  const char *oem_id, const char *oem_table_id);
>  
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 9adf1887da..182095d104 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -43,7 +43,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>  
>  #define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> +#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
>  
> -void build_srat_generic_pci_initiator(GArray *table_data);
> +void build_srat_generic_affinity_structures(GArray *table_data);
>  
>  #endif
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..5456e24883 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
>      PXBDev parent_obj;
>  } PXBPCIEDev;
>  
> +#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>  
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> new file mode 100644
> index 0000000000..8491aaf5ec
> --- /dev/null
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/acpi_generic_initiator.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/boards.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_device.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +
> +typedef struct AcpiGenericInitiatorClass {
> +    ObjectClass parent_class;
> +} AcpiGenericInitiatorClass;
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
> +                   ACPI_GENERIC_INITIATOR, OBJECT,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
> +
> +static void acpi_generic_initiator_init(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    gi->node = MAX_NODES;
> +    gi->pci_dev = NULL;
> +}
> +
> +static void acpi_generic_initiator_finalize(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    g_free(gi->pci_dev);
> +}
> +
> +static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
> +                                                  Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    gi->pci_dev = g_strdup(val);
> +}
> +
> +static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        error_printf("%s: Invalid NUMA node specified\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    gi->node = value;
> +    ms->numa_state->nodes[gi->node].has_gi = true;
> +}
> +
> +static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-dev", NULL,
> +        acpi_generic_initiator_set_pci_device);
> +    object_class_property_add(oc, "node", "int", NULL,
> +        acpi_generic_initiator_set_node, NULL, NULL);
> +}
> +
> +typedef struct AcpiGenericPortClass {
> +    ObjectClass parent_class;
> +} AcpiGenericPortClass;
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
> +                   ACPI_GENERIC_PORT, OBJECT,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
> +
> +static void acpi_generic_port_init(Object *obj)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    gp->node = MAX_NODES;
> +    gp->pci_bus = NULL;
> +}
> +
> +static void acpi_generic_port_finalize(Object *obj)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    g_free(gp->pci_bus);
> +}
> +
> +static void acpi_generic_port_set_pci_bus(Object *obj, const char *val,
> +                                          Error **errp)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    gp->pci_bus = g_strdup(val);
> +}
> +
> +static void acpi_generic_port_set_node(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        error_printf("%s: Invalid NUMA node specified\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    gp->node = value;
> +}
> +
> +static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-bus", NULL,
> +        acpi_generic_port_set_pci_bus);
> +    object_class_property_add(oc, "node", "int", NULL,
> +        acpi_generic_port_set_node, NULL, NULL);
> +}
> +
> +static int build_acpi_generic_initiator(Object *obj, void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    AcpiGenericInitiator *gi;
> +    GArray *table_data = opaque;
> +    uint8_t bus, devfn;
> +    Object *o;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +        return 0;
> +    }
> +
> +    gi = ACPI_GENERIC_INITIATOR(obj);
> +    if (gi->node >= ms->numa_state->num_nodes) {
> +        error_printf("%s: Specified node %d is invalid.\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
> +        exit(1);
> +    }
> +
> +    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
> +    if (!o) {
> +        error_printf("%s: Specified device must be a PCI device.\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    bus = object_property_get_uint(o, "bus", &error_fatal);
> +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> +
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> +
> +    return 0;
> +}
> +
> +static int build_acpi_generic_port(Object *obj, void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const char *hid = "ACPI0016";
> +    GArray *table_data = opaque;
> +    AcpiGenericPort *gp;
> +    uint32_t uid;
> +    Object *o;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
> +        return 0;
> +    }
> +
> +    gp = ACPI_GENERIC_PORT(obj);
> +
> +    if (gp->node >= ms->numa_state->num_nodes) {
> +        error_printf("%s: node %d is invalid.\n",
> +                     TYPE_ACPI_GENERIC_PORT, gp->node);
> +        exit(1);
> +    }
> +
> +    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
> +    if (!o) {
> +        error_printf("%s: device must be a CXL host bridge.\n",
> +                     TYPE_ACPI_GENERIC_PORT);
> +        exit(1);
> +    }
> +
> +    uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
> +    build_srat_acpi_generic_port(table_data, gp->node, hid, uid);
> +
> +    return 0;
> +}
> +
> +void build_srat_generic_pci_initiator(GArray *table_data)
> +{
> +    object_child_foreach_recursive(object_get_root(),
> +                                   build_acpi_generic_initiator,
> +                                   table_data);
> +    object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
> +                                   table_data);
> +}
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 968b654e58..4067100dd6 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1955,6 +1955,19 @@ static void build_append_srat_pci_device_handle(GArray *table_data,
>      build_append_int_noprefix(table_data, 0, 12);
>  }
>  
> +static void build_append_srat_acpi_device_handle(GArray *table_data,
> +                                                 const char *hid,
> +                                                 uint32_t uid)
> +{
> +    assert(strlen(hid) == 8);
> +    /* Device Handle - ACPI */
> +    for (int i = 0; i < sizeof(hid); i++) {
> +        build_append_int_noprefix(table_data, hid[i], 1);
> +    }
> +    build_append_int_noprefix(table_data, uid, 4);
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
> +
>  /*
>   * ACPI spec, Revision 6.3
>   * 5.2.16.6 Generic Initiator Affinity Structure
> @@ -1982,6 +1995,33 @@ void build_srat_pci_generic_initiator(GArray *table_data, int node,
>      build_append_int_noprefix(table_data, 0, 4);
>  }
>  
> +/*
> + * ACPI spec, Revision 6.5
> + * 5.2.16.7 Generic Port Affinity Structure
> + *   With ACPI Device Handle.
> + */
> +void build_srat_acpi_generic_port(GArray *table_data, int node,
> +                                  const char *hid,
> +                                  uint32_t uid)
> +{
> +    /* Type */
> +    build_append_int_noprefix(table_data, 6, 1);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Device Handle Type: ACPI */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Proximity Domain */
> +    build_append_int_noprefix(table_data, node, 4);
> +    /* Device Handle */
> +    build_append_srat_acpi_device_handle(table_data, hid, uid);
> +    /* Flags - GP Enabled */
> +    build_append_int_noprefix(table_data, 1, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
> +
>  /*
>   * ACPI spec 5.2.17 System Locality Distance Information Table
>   * (Revision 2.0 or later)
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index f68be9ea17..b9e2776966 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -29,6 +29,7 @@
>  #include "hw/boards.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/pci/pcie_host.h"
>  
> @@ -171,9 +172,116 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>      return 0;
>  }
>  
> -void build_srat_generic_pci_initiator(GArray *table_data)
> +typedef struct AcpiGenericPort {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *pci_bus;
> +    uint16_t node;
> +} AcpiGenericPort;
> +
> +typedef struct AcpiGenericPortClass {
> +    ObjectClass parent_class;
> +} AcpiGenericPortClass;
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
> +                   ACPI_GENERIC_PORT, OBJECT,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
> +
> +static void acpi_generic_port_init(Object *obj)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    gp->node = MAX_NODES;
> +    gp->pci_bus = NULL;
> +}
> +
> +static void acpi_generic_port_finalize(Object *obj)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    g_free(gp->pci_bus);
> +}
> +
> +static void acpi_generic_port_set_pci_bus(Object *obj, const char *val,
> +                                          Error **errp)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    gp->pci_bus = g_strdup(val);
> +}
> +
> +static void acpi_generic_port_set_node(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        error_printf("%s: Invalid NUMA node specified\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    gp->node = value;
> +}
> +
> +static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-bus", NULL,
> +        acpi_generic_port_set_pci_bus);
> +    object_class_property_add(oc, "node", "int", NULL,
> +        acpi_generic_port_set_node, NULL, NULL);
> +}
> +
> +static int build_acpi_generic_port(Object *obj, void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const char *hid = "ACPI0016";
> +    GArray *table_data = opaque;
> +    AcpiGenericPort *gp;
> +    uint32_t uid;
> +    Object *o;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
> +        return 0;
> +    }
> +
> +    gp = ACPI_GENERIC_PORT(obj);
> +
> +    if (gp->node >= ms->numa_state->num_nodes) {
> +        error_printf("%s: node %d is invalid.\n",
> +                     TYPE_ACPI_GENERIC_PORT, gp->node);
> +        exit(1);
> +    }
> +
> +    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
> +    if (!o) {
> +        error_printf("%s: device must be a CXL host bridge.\n",
> +                     TYPE_ACPI_GENERIC_PORT);
> +       exit(1);
> +    }
> +
> +    uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
> +    build_srat_acpi_generic_port(table_data, gp->node, hid, uid);
> +
> +    return 0;
> +}
> +
> +void build_srat_generic_affinity_structures(GArray *table_data)
>  {
>      object_child_foreach_recursive(object_get_root(),
>                                     build_acpi_generic_initiator,
>                                     table_data);
> +    object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
> +                                   table_data);
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1a5aa0d55d..31956410ed 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -504,7 +504,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      }
>  
> -    build_srat_generic_pci_initiator(table_data);
> +    build_srat_generic_affinity_structures(table_data);
>  
>      if (ms->nvdimms_state->is_enabled) {
>          nvdimm_build_srat(table_data);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d37b9238a..446adcc602 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2046,7 +2046,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>          build_srat_memory(table_data, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
>      }
>  
> -    build_srat_generic_pci_initiator(table_data);
> +    build_srat_generic_affinity_structures(table_data);
>  
>      /*
>       * Entry is required for Windows to enable memory hotplug in OS
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 92d39b917a..1c51f3f5b6 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
>                           TYPE_PXB_PCIE_BUS)
>  
> -#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
>                           TYPE_PXB_CXL_BUS)
>  

