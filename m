Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA16BC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 18:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJLSWS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJLSV6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 14:21:58 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D81FF8F9
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id i12so11432977qvs.2
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AceOVYAZvjJjLb8exqkdX1wLYvKvrZtVmuEiCslseZI=;
        b=aSA+pkgnYx0hMefqJq4DRwXxtfVp6jEEIMdRvTUIIIcOQgwtNm05qVnGy47UEhz9H0
         PtSBBz0M5uAszKR7TMpetKyOM8jEpIoS5t+v4PJRTshSx2YPDtI7u9FXCarJVo78mHeB
         vKYX7Lvdtp4SGfhBibmwD3Okge2sTfuBkwVD+u/UVoohu8QhiVgUACsoSbXGVWIxBZMe
         jSLIlEOjOlfe4tif1YowqL0r0XFV2swJBYN+h9+w7Mu1QRm5D0FvLkgx8gZajVIgCcHk
         iFIJ+ISudJZ1ERfD+Ap9JePwnkdXkh9wK6MKbp7Dw53UVFLUo//2Vj+zCbz1o+PBzU6Z
         /JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AceOVYAZvjJjLb8exqkdX1wLYvKvrZtVmuEiCslseZI=;
        b=VVpJAhoZr8hLtzaQL7WBdch9yC9wqKXJSasYsJgTR6h0tnTmvbdWG5gJz9cOOpn1p6
         Vw25LN4l8zjHCtdSPsQyWkw3UqfTGdcoM+Rr5ZaP3yOrNL8EeoYHovzCZ6qRMk0B5dCc
         ffmo0aQra6M3NL2fbbHwez9ql8wNsdMRSw6Sw8x/ArWjoUY+2FYHElv+flp/vgIzxM5/
         V9JBanHbPUERzOgF2LzrwKW7V9zcKny1VR0wfiuOtl0VfRDBlvPIwC+Br2OWHdFI4eu5
         9xhosVkgH1vEqvg/B9n/+pec3XTzOHVYG5YDXvOi1PV7kZhZumEftkjxcSdSA0x+xAQn
         UnKw==
X-Gm-Message-State: ACrzQf01tMlkYdaVmuhAUY2gXbzGPmYzbZtL8uyJd9+n23qNQgeoMvDv
        lcqfii3CWrajGubvcPyWDd2MHimvdA==
X-Google-Smtp-Source: AMsMyM68odWX1hmyB/gzZd0DHqyh1kSaA+x32AALjeiL/j05aQaK8OJLEIkD10wU4/i564D1glemkQ==
X-Received: by 2002:a05:6214:29ee:b0:4b1:c1d2:6635 with SMTP id jv14-20020a05621429ee00b004b1c1d26635mr24559769qvb.82.1665598889861;
        Wed, 12 Oct 2022 11:21:29 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006ee9d734479sm920228qkb.33.2022.10.12.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:21:29 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange
Date:   Wed, 12 Oct 2022 14:21:15 -0400
Message-Id: <20221012182120.174142-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Included in this response is a recommended patch set on top of this
patch that resolves a number of issues, including style and a heap
corruption bug.

The purpose of this patch set is to refactor the CDAT initialization
code to support future patch sets that will introduce multi-region
support in CXL Type3 devices.

1) Checkpatch errors in the immediately prior patch
2) Flatting of code in cdat initialization
3) Changes in allocation and error checking for cleanliness
4) Change in the allocation/free strategy of CDAT sub-tables to simplify
   multi-region allocation in the future.  Also resolves a heap
   corruption bug
5) Refactor of CDAT initialization code into a function that initializes
   sub-tables per memory-region.

Gregory Price (5):
  hw/mem/cxl_type3: fix checkpatch errors
  hw/mem/cxl_type3: Pull validation checks ahead of functional code
  hw/mem/cxl_type3: CDAT pre-allocate and check resources prior to work
  hw/mem/cxl_type3: Change the CDAT allocation/free strategy
  hw/mem/cxl_type3: Refactor CDAT sub-table entry initialization into a
    function

 hw/mem/cxl_type3.c | 240 +++++++++++++++++++++++----------------------
 1 file changed, 122 insertions(+), 118 deletions(-)

-- 
2.37.3

