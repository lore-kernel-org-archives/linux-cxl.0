Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D218ECAAD1
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Aug 2022 11:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHaLWa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaLW3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Aug 2022 07:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48647B8A44
        for <linux-cxl@vger.kernel.org>; Wed, 31 Aug 2022 04:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661944947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+WnYdnN9R8QTFDw/LsHaMNoGAq/c/xLynjoNZ/hHnyw=;
        b=Cl92RjBOFuoTfGtTbQ2nUM7jTUoJkNP6xgoPN31e99twS9JlKM5Zd24GVv9zk5gdQ6773n
        gKDJB6nyGZqmQ+P21Cm/o19Whgz2pxZotMYQi8+coOerCl6Wo8LWfCct2m0qdtG15l5vp+
        ENYV/mj0UJ+3VzCNf/Y7HIt68ffui9k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-tmzWAQSIMq2hzxRKtLGeuw-1; Wed, 31 Aug 2022 07:22:26 -0400
X-MC-Unique: tmzWAQSIMq2hzxRKtLGeuw-1
Received: by mail-ed1-f71.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso9328801edd.2
        for <linux-cxl@vger.kernel.org>; Wed, 31 Aug 2022 04:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+WnYdnN9R8QTFDw/LsHaMNoGAq/c/xLynjoNZ/hHnyw=;
        b=BTbRcXDKKl9zGVOplPFypxseAmZS1jR5KnhywfQ4aM52DTBoeVYNz+Q+WY53vNMgtP
         NMHwtFDxHiMk7HoSMt1kva/wAwpXMA8bdKE0UZYlzMToId7yJeDutkY+z1DoUBkrNjhk
         eiwhl2WDASvEatcPg83wotFunS5ffunadmcNJBtabkHw987AJ32xYWskf3bRk165i5Gx
         z2yXiwkcnQZmpeHtXCI85h71nedVEigpLvAvRrMtiOlnGHfK+ISCKe69PTp2waLxspAR
         +PTWmy2jwtqksysngCEbIjZjBXZHOutjObHTqEqoEFha0GRtyefZ5NUflAl/AhcPcs92
         PS9w==
X-Gm-Message-State: ACgBeo11wC0hbqaavj2G7djBhuAafqZ16yPRdXUAiUfcMk01tqo3ooQf
        gC1h7pu3hEXqI4k2sLfo7yqWsV/KzGZGOieyagFp7V9nfr0OfBezUstcJCPr+ARox3toDKl8PkR
        3AukD/155q6+peG8VNQU8CHtn41XNVzZXP9NW
X-Received: by 2002:a17:907:6293:b0:73d:b27b:e594 with SMTP id nd19-20020a170907629300b0073db27be594mr20413101ejc.526.1661944945070;
        Wed, 31 Aug 2022 04:22:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5X1mRwimgHP1UnC7CsNAophUYAVVVjp1xmD2N38i6fLZrHumE1g/zMTTW9WG6KLPCbL94y8ClBlZ/HurzrsUc=
X-Received: by 2002:a17:907:6293:b0:73d:b27b:e594 with SMTP id
 nd19-20020a170907629300b0073db27be594mr20413088ejc.526.1661944944741; Wed, 31
 Aug 2022 04:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <166188306499.3409478.15310054338186313752.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166188306499.3409478.15310054338186313752.stgit@dwillia2-xfh.jf.intel.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 31 Aug 2022 19:22:12 +0800
Message-ID: <CAHj4cs-ojsuqvEZwC0VK9nDPfDCtzoV34vkq0TSzEH7-vV6Lwg@mail.gmail.com>
Subject: Re: [ndctl PATCH] cxl/test: Skip tests in the absence of the cxl_test module
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Tested-by: Yi Zhang <yi.zhang@redhat.com>

# meson test --suite cxl  -C build
ninja: Entering directory `/root/ndctl/build'
[1/44] Generating version.h with a custom command
1/4 ndctl:cxl / cxl-topology.sh             SKIP             0.08s
exit status 77
2/4 ndctl:cxl / cxl-region-sysfs.sh         SKIP             0.08s
exit status 77
3/4 ndctl:cxl / cxl-labels.sh               SKIP             0.08s
exit status 77
4/4 ndctl:cxl / cxl-create-region.sh        SKIP             0.08s
exit status 77

Ok:                 0
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            4
Timeout:            0

Full log written to /root/ndctl/build/meson-logs/testlog.txt

On Wed, Aug 31, 2022 at 2:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Similar to cases when nfit_test is missing, SKIP rather than FAIL the tests
> that depend on cxl_test.ko when it is missing.
>
> Link: https://github.com/pmem/ndctl/issues/221
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  test/cxl-create-region.sh |    3 ++-
>  test/cxl-labels.sh        |    3 ++-
>  test/cxl-region-sysfs.sh  |    3 ++-
>  test/cxl-topology.sh      |    3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
> index 66df38f41549..82aad3a7285a 100644
> --- a/test/cxl-create-region.sh
> +++ b/test/cxl-create-region.sh
> @@ -4,7 +4,7 @@
>
>  . $(dirname $0)/common
>
> -rc=1
> +rc=77
>
>  set -ex
>
> @@ -14,6 +14,7 @@ check_prereq "jq"
>
>  modprobe -r cxl_test
>  modprobe cxl_test
> +rc=1
>  udevadm settle
>
>  destroy_regions()
> diff --git a/test/cxl-labels.sh b/test/cxl-labels.sh
> index e782e2dec246..3bf1e6e995b6 100644
> --- a/test/cxl-labels.sh
> +++ b/test/cxl-labels.sh
> @@ -4,7 +4,7 @@
>
>  . $(dirname $0)/common
>
> -rc=1
> +rc=77
>
>  set -ex
>
> @@ -14,6 +14,7 @@ check_prereq "jq"
>
>  modprobe -r cxl_test
>  modprobe cxl_test
> +rc=1
>  udevadm settle
>
>  test_label_ops()
> diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
> index ae0f55653814..63186b60dfec 100644
> --- a/test/cxl-region-sysfs.sh
> +++ b/test/cxl-region-sysfs.sh
> @@ -4,7 +4,7 @@
>
>  . $(dirname $0)/common
>
> -rc=1
> +rc=77
>
>  set -ex
>
> @@ -14,6 +14,7 @@ check_prereq "jq"
>
>  modprobe -r cxl_test
>  modprobe cxl_test
> +rc=1
>  udevadm settle
>
>  # THEORY OF OPERATION: Create a x8 interleave across the pmem capacity
> diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
> index f7da83e60f7a..5148e6dd79f4 100644
> --- a/test/cxl-topology.sh
> +++ b/test/cxl-topology.sh
> @@ -4,7 +4,7 @@
>
>  . $(dirname $0)/common
>
> -rc=1
> +rc=77
>
>  set -ex
>
> @@ -14,6 +14,7 @@ check_prereq "jq"
>
>  modprobe -r cxl_test
>  modprobe cxl_test
> +rc=1
>  udevadm settle
>
>  # THEORY OF OPERATION: Validate the hard coded assumptions of the
>


-- 
Best Regards,
  Yi Zhang

