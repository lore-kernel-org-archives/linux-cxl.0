Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F20DC77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjDSIbw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjDSIbn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 04:31:43 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99733AD23
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 01:31:29 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54ee0b73e08so493063537b3.0
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681893088; x=1684485088;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XQKlxolxu57/urtOdhAfoNxCg5j9w4kz8MMZUwQknvA=;
        b=EApDnOZFC5zCTGqNc3oSLIVrSvdxkg3dO8YfwAriazGJhh3oJic9lSG5mVkfr+BfZR
         f/kfo7gdUGUUVn2wjmGL/L1C49G8WXZXAs9s5kqzjUHlISh1BIs4RIw3ccAUw9o7idzn
         l+BiTHol4YzC3tWv7kvbnfIELVjbrgVQeqwm2lpBhDRogDavDwBPaLM8Hw7enn5kRHV+
         O9EcjwrIEfky1AHkO6S1Bbsptx+uTbIgyCTVNX4nZjL9782p6/wjmhQukHiyb66x1+dN
         3hwgjPchWu3iRBe7a+S8G0vVFURQv8BxtuPG2Z38y4u9drQhj3U+gRjBKTFd++7avnPI
         KcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893088; x=1684485088;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQKlxolxu57/urtOdhAfoNxCg5j9w4kz8MMZUwQknvA=;
        b=QrnrswnHOisFV96zDi+GaIu4RVmvsJV90W59EjaM6jIOOzKfHxmdl1JiQADpe+vNHY
         J6pDWesrtoRjIaPtXBxC73kzOU1YEfldGDLK3ws6ktq0Va7eBMmEkrBdMpzsTL7C+CK/
         ubZAsEMUuIB+zr+HTLIrR/Z9oCiyELBooZwV3uFxlR8CknRLUxQwBbSZJplW0d9PMxJc
         QTJ0xx1U8wNfciHXGShGiwNjZg2fMetHgfV/F4YQv1Vt5diHCNzrgek64v0zbVa6VRRc
         U+lF3At0Aj1hhrOWmZYU6o+k0EBhfi9xvPKGEgtjxObEcQE2JaA0UeJ/Fl9+Mkug6JD3
         tzZw==
X-Gm-Message-State: AAQBX9c8gwbTnA6HnwPHR0yX83/8wuBUYfdgR25gO3o9HMak5j/bWGOZ
        nnRVVdqHYjPdyzkbLXXElh9M/NWkpmaQfRpJ+QwXutwG5zk=
X-Google-Smtp-Source: AKy350Yvv39dXqtPqpancjbruGbUmc0WAtyjLIr2ai4RdxjziWn6iWhN3DFZ9Fom4OfEEZVq3W4+3ieTigUgcMJcdow=
X-Received: by 2002:a0d:f687:0:b0:54f:dca7:6f6b with SMTP id
 g129-20020a0df687000000b0054fdca76f6bmr2633619ywf.43.1681893088522; Wed, 19
 Apr 2023 01:31:28 -0700 (PDT)
MIME-Version: 1.0
From:   RAGHU H <raghuhack78@gmail.com>
Date:   Wed, 19 Apr 2023 14:01:17 +0530
Message-ID: <CAGWUp4qXXOsFgJu9E__Y9FGhK0ARteOF-mP1P19rd3_5K=mgNg@mail.gmail.com>
Subject: Usage of tools/testing/cxl
To:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

Please pardon my ignorance, but would like to understand how to use
tools/testing/cxl to understand the current kernel implementation of
cxl code base & test framework(tools/testing/cxl).

I have tried "make -C tools/testing/selftests run_tests", but it's a
bit of a stretch and executes all the tests which may not be related
to my quest for CXL.

Also I see some compiler & linker errors like below when using "make
-C tools/testing/selftests"

gcc -I/usr/include/libmnl     nf-queue.c -lmnl -o
/usr/src/kernels/linux-stable/tools/testing/selftests/netfilter/nf-queue
nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or
directory
   13 | #include <libmnl/libmnl.h>
...
/usr/bin/ld: cannot find -lm: No such file or directory
/usr/bin/ld: cannot find -lc: No such file or directory

/usr/include/numa.h
/usr/include/numacompat1.h
/usr/include/numaif.h
/usr/lib64/libnuma.so
/usr/lib64/pkgconfig/numa.pc
/usr/share/man/man3/numa.3.gz

I have the following dev libraries installed in my guest
/usr/lib/.build-id
/usr/lib/.build-id/a8
/usr/lib/.build-id/a8/47cfa4a60942edf111e055e5c23d9574c06e77
/usr/lib64/libmnl.so.0
/usr/lib64/libmnl.so.0.2.0
/usr/share/doc/libmnl
/usr/share/doc/libmnl/README
/usr/share/licenses/libmnl
/usr/share/licenses/libmnl/COPYING


Any help here would be appreciated!

Regards
