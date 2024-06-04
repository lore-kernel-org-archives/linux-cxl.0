Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B38F45
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509558; cv=none; b=aKu7tzl/jrUf4ILo3QkvRwbNjvwpBo9NHLTopRqanqxDk61tJTqjz/alCqH5DEKWPX6AX71K6WgOvIwKDSTZswVFJAlNgntQ+CLeyE0EVP5iYOvpyI309o3cmbymwLlxrEf2TEcMv8iMLixbPfVXuFxHJxcOy4z61OotkD6Ppe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509558; c=relaxed/simple;
	bh=SDR5yLdHT91TgK8eMFgGq8ccOfPDlKw1GmYZp7XFd7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7kF7bY5C2duGRO4g9+sMM6T5VeMx+PSHsUfucvN9SwBQQomUzC4rY8xd1N7Ptn0V3sds9+XMBKXVa5njqvgVy6hIOv5+BILL6MsH3wjmsam0Wh0xj15joD255Xb6C4faB2l+3CFRbVwv3/jGgc389lXyjuiSASn4K32HcJ/hmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gq0y504Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq0y504Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxZPYF87FmrxCwqmN5MY/xGLhuyludxMEYxLRtPB7bY=;
	b=gq0y504ZTtGs4UoNMQLaQOV5BZCbn/E4W5N6bAIcSx/vE1fpC4OMlQxBkBprlLCPa0b9Lw
	GI1Ed/m96mhoKYkiadh7683Myhpa+L3mwX5MvNzL5QVCV0ReQL8ph/hKxtuiRt4YBXcXbA
	/s3DUOUSwMl8Q0C3GJ3Kl9yRG5FR15c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-phpX-zSdM1aIZZsrf9LheA-1; Tue, 04 Jun 2024 09:59:12 -0400
X-MC-Unique: phpX-zSdM1aIZZsrf9LheA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 157A78007BA;
	Tue,  4 Jun 2024 13:59:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EE3640D1B69;
	Tue,  4 Jun 2024 13:59:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A0C8E21E6687; Tue,  4 Jun 2024 15:59:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>,  <qemu-devel@nongnu.org>,  <ankita@nvidia.com>,
  <marcel.apfelbaum@gmail.com>,  <philmd@linaro.org>,  Dave Jiang
 <dave.jiang@intel.com>,  Huang Ying <ying.huang@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  <eduardo@habkost.net>,  <imammedo@redhat.com>,
  <linux-cxl@vger.kernel.org>,  <linuxarm@huawei.com>,  Michael Roth
 <michael.roth@amd.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 3/6] hw/acpi: Generic Port Affinity Structure support
In-Reply-To: <20240524100507.32106-4-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 24 May 2024 11:05:04 +0100")
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
	<20240524100507.32106-4-Jonathan.Cameron@huawei.com>
Date: Tue, 04 Jun 2024 15:59:10 +0200
Message-ID: <87zfs06c7l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> These are very similar to the recently added Generic Initiators
> but instead of representing an initiator of memory traffic they
> represent an edge point beyond which may lie either targets or
> initiators.  Here we add these ports such that they may
> be targets of hmat_lb records to describe the latency and
> bandwidth from host side initiators to the port.  A descoverable

I figure your mean "discoverable", and ...

> mechanism such as UEFI CDAT read from CXL devices and switches
> is used to discover the remainder fo the path and the OS can build

... " of the path, and the OS".

> up full latency and bandwidth numbers as need for work and data
> placement decisions.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Updates to QMP documentation to provide a lot more information
>     on the parameters.
> ---
>  qapi/qom.json                            |  35 ++++++
>  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
>  include/hw/pci/pci_bridge.h              |   1 +
>  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
>  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>  5 files changed, 158 insertions(+), 38 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 38dde6d785..9d1d86bdad 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -826,6 +826,39 @@
>    'data': { 'pci-dev': 'str',
>              'node': 'uint32' } }
>  
> +

Extra blank line.

> +##
> +# @AcpiGenericPortProperties:
> +#
> +# Properties for acpi-generic-port objects.
> +#
> +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> +#     this SRAT Generic Port Affinity Structure.  This is the same as
> +#     the bus parameter for the root ports attached to this host bridge.
> +#     The resulting SRAT Generic Port Affinity Structure will refer to
> +#     the ACPI object in DSDT that represents the host bridge (e.g.
> +#     ACPI0016 for CXL host bridges.) See ACPI 6.5 Section 5.2.16.7 for

I'd put the period behind the parenthesis: "bridges).  See ACPI"

> +#     more information.
> +#
> +# @node: Similar to a NUMA node ID, but instead of providing a reference
> +#     point used for defining NUMA distances and access characteristics
> +#     to memory or from an initiator (e.g. CPU), this node defines the
> +#     boundary point between non-discoverable system buses which must be
> +#     described by firmware, and a discoverable bus.  NUMA distances
> +#     and access characteristics are defined to and from that point.
> +#     For system software to establish full initiator to target
> +#     characteristics this information must be combined with information
> +#     retrieved from the discoverable part of the path.  An example would
> +#     use CDAT (see UEFI.org) information read from devices and switches
> +#     in conjunction with link characteristics read from PCIe
> +#     Configuration space.

Lines are slightly wide in places.  

Together:

   # @pci-bus: QOM path of the PCI bus of the hostbridge associated with
   #     this SRAT Generic Port Affinity Structure.  This is the same as
   #     the bus parameter for the root ports attached to this host
   #     bridge.  The resulting SRAT Generic Port Affinity Structure will
   #     refer to the ACPI object in DSDT that represents the host bridge
   #     (e.g. ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
   #     5.2.16.7 for more information.
   #
   # @node: Similar to a NUMA node ID, but instead of providing a
   #     reference point used for defining NUMA distances and access
   #     characteristics to memory or from an initiator (e.g. CPU), this
   #     node defines the boundary point between non-discoverable system
   #     buses which must be described by firmware, and a discoverable
   #     bus.  NUMA distances and access characteristics are defined to
   #     and from that point.  For system software to establish full
   #     initiator to target characteristics this information must be
   #     combined with information retrieved from the discoverable part
   #     of the path.  An example would use CDAT (see UEFI.org)
   #     information read from devices and switches in conjunction with
   #     link characteristics read from PCIe Configuration space.

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
> @@ -953,6 +986,7 @@
>  { 'enum': 'ObjectType',
>    'data': [
>      'acpi-generic-initiator',
> +    'acpi-generic-port',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -1025,6 +1059,7 @@
>    'discriminator': 'qom-type',
>    'data': {
>        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'acpi-generic-port':          'AcpiGenericPortProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',

Preferably with these touch-ups
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]

