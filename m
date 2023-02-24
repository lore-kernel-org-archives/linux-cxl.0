Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBEC64ED8
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBXTyT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBXTyT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:54:19 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B7831E02
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:54:02 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5974E7E1BD7;
        Fri, 24 Feb 2023 19:54:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7CFEC7E1936;
        Fri, 24 Feb 2023 19:54:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268440; a=rsa-sha256;
        cv=none;
        b=c+6RVOWyKN3xGRzFzfTtroLMK0C9ReIU4tfK9SYtpj7EVk+tAkCyqXjzg+fgW78BktAvgF
        aHXuzZr6YxwA5lZKstUIzbI9AImVq/DvuOxquLs7+zzW899hSpxpQWqYY5WO1W8i5Idamr
        oc0jZINJA8LtPw6EL9RhEx+W4WHCuAoRElMhfRNUHhDYRUrY+v9SNdxOkDW749GHGvwFPV
        m4kAyX3c1uaBhdgb9VLWoMBNfyd2gLodXnrdxLg2CPMW/O19KmyhThxJLw5EC3yj7RDxQx
        ebKEZcQzSWnv7Zdcu0P4R9DR2aU90nPn6fbE3IMTvmfjTWkFviv7uqban01Abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ks1BIS73vSFTP4WP3oyu3+LzlgtHANuVIUGPpKRWzDg=;
        b=5XaqQOC89MrSTJIpFSk2jyYaUQmPZWBkVrCRIUVWhycHyRNqPmX8vhbJLk/srK1w9y25rn
        yBkwUhhnSmf82Rdnz0Zox1TIBU3ceW2SwMjjESqBxwIzU6lzbiFFtcjFKbss1SGyNByJ8h
        liLSW9Scpfsz2rYBCZSwm9mFm6a7RoLAhXklrxt8CXQ95GTNKHC3bHsCRin1gYNIdbtaKQ
        KBZsLqRve5bFMEsOqpORzYuxHBSCS6Cnwk95CKDRc1CtOShvvO9ZNZ8Autx6doHcjbisFs
        4T04uFjUgKm79EinEpTnvW2bOpg2qSONrG7MD1YmmcdW5oySdZsJoEHp9oUTAw==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-mldnf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Battle: 35bb38347990090c_1677268440917_249620734
X-MC-Loop-Signature: 1677268440917:2454546175
X-MC-Ingress-Time: 1677268440917
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.110 (trex/6.7.1);
        Fri, 24 Feb 2023 19:54:00 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgZH0gLxz2Q;
        Fri, 24 Feb 2023 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268440;
        bh=ks1BIS73vSFTP4WP3oyu3+LzlgtHANuVIUGPpKRWzDg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=E49j/XA4mvbSB+wQ+2441Fsg5VZqYj41cMcHP6qbCAHYK50ZH+ap13lin+dk2izHH
         /DhPyvKDR0/w5AW7a719xOUHWc6eFTzZ6xt+AHCRYQG9pkxFcejbCrqHMP54ac3I8N
         MLQgdh8HNrmHmI6dUclKsHnas4CuIP6xbml1Ns53/alK5ITX+WgvLWMY7n1wwg9vwY
         RF2ZacO2OzAb06tgc+Xltj7rObLpSPnM3msZoeqwSHgyczA6O35ER5bQeyPmvEyQ6T
         BBdZuzttgxuyGPj5yuzS7HSA59Tft/4PcIL7mx5ixSeWKD6YDuMV69N06fSn7TpJSa
         XbuvMsMuyZBFw==
Date:   Fri, 24 Feb 2023 11:25:31 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave.jiang@intel.com
Subject: Re: [PATCH v3 0/7] cxl: Background cmds and device sanitation
Message-ID: <20230224192531.ahohjuzrtp5flkec@offworld>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

+Cc Dave (sorry).

On Fri, 24 Feb 2023, Davidlohr Bueso wrote:

>Hello,
>
>This series adds support for the rest of the security related cxl operations
>which are not strictly dependent on PMEM.
>
>Patch 1 adds the required background cmd handling bits (polling and irq).
>This is really the main motivation of the series as there are various
>features that will need this regardless of sanitation.
>
>Patch 2 adds a new sysfs 'security/state' file, which shows "disabled" if
>no security features are available - which is more intuitive than no showing
>it.
>
>Patch 3 adds a way to check if the device is actively used by tracking regions
>with target the memdevice to sanitize. I realize this might not be what is
>desired and wanted to get the expectations for this. This is more of a RFC
>patch.
>
>Patches 4-7 add the Sanitation and Secure Erase support, per CXL3.0 specs.
>
>These changes have been tested with both the mock device as well as with qemu[0,1].
>
>Changes from v2 (https://lore.kernel.org/linux-cxl/20221206011501.464916-1-dave@stgolabs.net/):
>- Redid the bacground cmd handling to use a syncronous approach instead.
>- Added cxl_memdev_active_region() to check if the memdevice is being used
>  (actively decoding any HPA ranges).
>- Create a new security sysfs directory with a 'state' file which is always visible.
>- The sysfs files' to trigger the security commands is only visible if
>  cpu_cache_has_invalidate_memregion().
>- Added a sanitize test for the mock device.
>
>Please consider for v6.4.
>
>Thanks!
>
>[0]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce
>[1]: https://lore.kernel.org/linux-cxl/20230224194443.1990440-1-dave@stgolabs.net
>
>Davidlohr Bueso (7):
>  cxl/mbox: Add background cmd handling machinery
>  cxl/security: Add security state sysfs ABI
>  cxl/region: Add cxl_memdev_active_region()
>  cxl/mem: Support Sanitation
>  cxl/test: Add "Sanitize" opcode support
>  cxl/mem: Support Secure Erase
>  cxl/test: Add "Secure Erase" opcode support
>
> Documentation/ABI/testing/sysfs-bus-cxl |  34 +++++++
> drivers/cxl/core/mbox.c                 | 117 +++++++++++++++++++++++
> drivers/cxl/core/memdev.c               | 119 ++++++++++++++++++++++++
> drivers/cxl/core/region.c               |  33 ++++++-
> drivers/cxl/cxl.h                       |  13 +++
> drivers/cxl/cxlmem.h                    |  14 +++
> drivers/cxl/pci.c                       | 100 +++++++++++++++++++-
> tools/testing/cxl/test/mem.c            |  52 +++++++++++
> 8 files changed, 476 insertions(+), 6 deletions(-)
>
>--
>2.39.2
>
