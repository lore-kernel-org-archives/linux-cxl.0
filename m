Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B70101EE
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869789; cv=none; b=i2xjI2+ScnHYKnomDej6aDOehzMLlc6qrToGY7HaCKCWZbR1G6rUz9LRAA3fpV7i+2530sE/DTr1zZ4KcwMEM9aMcHejoIX/2j5EQJxEygjvJ1N7qqSq0qL7rDVGbwtXOnqMIZqphzbt6aoAlQDW0qONJ/CIqz7rjmsVyp93Txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869789; c=relaxed/simple;
	bh=1iZAe5Nd/eS9QuG1sllrbKMz+qv6MzHZlU988DwnoCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pHk7xu4BSZiZjmxbK4SVjN1T9Cdjfm9hCIbUnll1vZiodgb59mOwlG8TfB4ONMbpmuLm7JuOHbrIYwgcK2Nu6+iB0GRDHc2OL+V2kdOYYSYOPNMuYLuv2GyaLvt9X1PlbsW/uGE6uVwbztkW7uhRNDOJ6aMq4KahTd9FiqSELwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEvI4C06; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEvI4C06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713869787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8c3Fyi1pBUNFxJAAiarqfqftAmseD0yfDbT7jonBtY=;
	b=IEvI4C06DardzTB9uYX5LsO0zO/LNkJNm4nHscZWsLLqSTdxiXphDU8wjkiEKuky9afW0B
	TX38GJa2VrnrzdFWLYomzgAgOyAD3SYCjW2uZ74MoiUWCmHh6KO3QANASwYgWVyxoCIcSe
	xQbD/kzj2ZHaXB+v7S96tFJBQCleTk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-vI45iBszNiubaTkIwKfzqw-1; Tue, 23 Apr 2024 06:56:23 -0400
X-MC-Unique: vI45iBszNiubaTkIwKfzqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF8A5811000;
	Tue, 23 Apr 2024 10:56:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E6F5200A5C5;
	Tue, 23 Apr 2024 10:56:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1234321E6811; Tue, 23 Apr 2024 12:56:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <ankita@nvidia.com>,  <marcel.apfelbaum@gmail.com>,
  <philmd@linaro.org>,  <mst@redhat.com>,  <qemu-devel@nongnu.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Huang Ying <ying.huang@intel.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  <eduardo@habkost.net>,
  <imammedo@redhat.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
In-Reply-To: <20240403102927.31263-4-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Wed, 3 Apr 2024 11:29:24 +0100")
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
	<20240403102927.31263-4-Jonathan.Cameron@huawei.com>
Date: Tue, 23 Apr 2024 12:56:21 +0200
Message-ID: <87r0ewcppm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> These are very similar to the recently added Generic Initiators
> but instead of representing an initiator of memory traffic they
> represent an edge point beyond which may lie either targets or
> initiators.  Here we add these ports such that they may
> be targets of hmat_lb records to describe the latency and
> bandwidth from host side initiators to the port.  A descoverable
> mechanism such as UEFI CDAT read from CXL devices and switches
> is used to discover the remainder fo the path and the OS can build
> up full latency and bandwidth numbers as need for work and data
> placement decisions.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/qom.json                            |  18 +++
>  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
>  include/hw/pci/pci_bridge.h              |   1 +
>  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
>  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>  5 files changed, 141 insertions(+), 38 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 85e6b4f84a..5480d9ca24 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -826,6 +826,22 @@
>    'data': { 'pci-dev': 'str',
>              'node': 'uint32' } }
>  
> +
> +##
> +# @AcpiGenericPortProperties:
> +#
> +# Properties for acpi-generic-port objects.
> +#
> +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry

What's this exactly?  A QOM path?  A qdev ID?  Something else?

> +#
> +# @node: numa node associated with the PCI device

NUMA

Is this a NUMA node ID?

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
> @@ -944,6 +960,7 @@
>  { 'enum': 'ObjectType',
>    'data': [
>      'acpi-generic-initiator',
> +    'acpi-generic-port',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -1016,6 +1033,7 @@
>    'discriminator': 'qom-type',
>    'data': {
>        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'acpi-generic-port':          'AcpiGenericPortProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',

[...]

