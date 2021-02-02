Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70AC433E6
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA6961481
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 14:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhBBO25 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 09:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234457AbhBBO1z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Feb 2021 09:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612275988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nz1AHwjucO+44OER5CPS10byVA2GsstgeF5fA/2ib94=;
        b=Hzjp5gGwa2GH22Pd4sdKU96FGGcNHx8M/U29Ayh2SADIBOjCaU8MJTJ8+saaLKsHArRb+3
        VhjrIGoyk/5QmxfmUxBWhYJTUvqUIjISbl1ck/sXyYqoZ932iQHkjeD2WxmbW+eu9/VL4v
        /kYe5zFjbmSxFK4MrfFo3AlMwrY/AhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-i_ZUW0uyPbKV9fpihGPpzQ-1; Tue, 02 Feb 2021 09:26:24 -0500
X-MC-Unique: i_ZUW0uyPbKV9fpihGPpzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9814D107ACE3;
        Tue,  2 Feb 2021 14:26:22 +0000 (UTC)
Received: from [10.3.112.103] (ovpn-112-103.phx2.redhat.com [10.3.112.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54A49722C8;
        Tue,  2 Feb 2021 14:26:15 +0000 (UTC)
Subject: Re: [RFC PATCH v3 21/31] hw/cxl/device: Add a memory device (8.2.8.5)
To:     Ben Widawsky <ben.widawsky@intel.com>, qemu-devel@nongnu.org
Cc:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Markus Armbruster <armbru@redhat.com>,
        linux-cxl@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
 <20210202005948.241655-22-ben.widawsky@intel.com>
From:   Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ec610f0d-4719-43fd-9293-e5a18e00a7d3@redhat.com>
Date:   Tue, 2 Feb 2021 08:26:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202005948.241655-22-ben.widawsky@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 2/1/21 6:59 PM, Ben Widawsky wrote:
> A CXL memory device (AKA Type 3) is a CXL component that contains some
> combination of volatile and persistent memory. It also implements the
> previously defined mailbox interface as well as the memory device
> firmware interface.
> 
> Although the memory device is configured like a normal PCIe device, the
> memory traffic is on an entirely separate bus conceptually (using the
> same physical wires as PCIe, but different protocol).
> 
> The guest physical address for the memory device is part of a larger
> window which is owned by the platform. Currently, this is hardcoded as
> an object property on host bridge (PXB) creation, but that will need to
> change for interleaving.
> 
> The following example will create a 256M device in a 512M window:
> -object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
> -device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M"
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---

> +++ b/qapi/machine.json
> @@ -1394,6 +1394,7 @@
>  { 'union': 'MemoryDeviceInfo',
>    'data': { 'dimm': 'PCDIMMDeviceInfo',
>              'nvdimm': 'PCDIMMDeviceInfo',
> +            'cxl': 'PCDIMMDeviceInfo',
>              'virtio-pmem': 'VirtioPMEMDeviceInfo',
>              'virtio-mem': 'VirtioMEMDeviceInfo'
>            }

Missing documentation that 'cxl' was introduced in 6.0.  Also, is it
worth keeping the branches of this union in lexicographic order?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

