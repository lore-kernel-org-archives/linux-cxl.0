Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894FEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 19:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGTT67 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGTT66 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 15:58:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8571BE2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 12:58:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d75a77b69052e-403fab47687so10211781cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883136; x=1690487936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa8bJb04ZvnnRNi76wtYTjDMEYPR/K0aZDQRNb+Huq4=;
        b=YCf8bPc1cYh8csFGHCDH5OgYzlhnTh+TGOKxMOeVLCJxWAP9h/MRTI0ESXIXjN0yIv
         cHVx5O7Cod0KWsjpXauEuYW1F1l3XbA5xVMbGyik34vh227IcEUTRZIQO2nx6BAB2Ihu
         +1rvcwA16fJb1KIzJS0MCitSdtZ8/5NQLTWvv6DoiQ9cxzkXgGMgbsMvCFLJNldilCbv
         jKWoRpx4SOfOxOxDL9C9aESAPpRabVDogid7MJRyl2GFo3yOdr9ofIJ4B7nOV0oam4Ci
         ofL270lFrBkAx27TIQNwK63jxaEFRk6rY29gjQ+HPWQbhkVEi2g6tbu4gxWGNcBPRKvV
         GpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883136; x=1690487936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa8bJb04ZvnnRNi76wtYTjDMEYPR/K0aZDQRNb+Huq4=;
        b=E+2L62FZLA0Awk+16279CI8CeUSd4q93OJ3Xf10B/YYweok7Gyf1Vh1TkKv4inY37C
         9I92xGQCrEyfFNueeepiLcn7yn879OOwv5DBykah8xIKfLTRRy6VzDok2vLh3gtbjTCQ
         f8H0AsEQZnjitBoX9dDvEpkNnp0H4ombQxuZZlQUJbbIDfePdaYewz08QRACNExuGBlV
         wmz3I1mRYxhMPn9GKq6nzpZg3RKOk/ZY++IU7nY546F0DX+vd2LqpKH3NqQtYQry38DX
         nugRSdjChvrwIYa7rVQb4/8mTxz7AybWcGe0RENt2cPG3Tgf7FfxMlzjiDVQ9Z5zTx5/
         8XXQ==
X-Gm-Message-State: ABy/qLZicZYiuhWI7aCPrSzDkoxtJXuRTKCeZuYGUTI7oaJkh7Bppqur
        bxR6EO/wbybLwByehwfmHw==
X-Google-Smtp-Source: APBJJlETfN33UWv770rWJnBpgm1Ey0TWkso52q9W88hXKhV4uCHLE0X7bAen/XT3I4DSAIpG8/x/+g==
X-Received: by 2002:a05:622a:647:b0:403:b86d:f10e with SMTP id a7-20020a05622a064700b00403b86df10emr129479qtb.10.1689883136587;
        Thu, 20 Jul 2023 12:58:56 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bw14-20020a05622a098e00b00404e686bcd1sm672078qtb.72.2023.07.20.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:58:56 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC 0/2] Modify CCI cmd sets to be mutable
Date:   Thu, 20 Jul 2023 15:58:18 -0400
Message-Id: <20230720195819.17905-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This is on top of the proposed CCI changes by Jonathan.

Base repo: https://gitlab.com/jic23/qemu
Base branch: cxl-2023-07-17


A proposal to make the CCI cmd sets full members of their device,
and copy the const struct entries instead of referencing them.
This would allow child devices to inherit the parent device default
behavior, but with the flexibility to override without changing the
core device.

This also enables the base device to receive the commands via the
same /dev/cxl/XXXX device, simplifying testing.


An example of how one might override/add commands (paraphrased):


instantiating:

-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0
-device cxl-my-cmds,target=cxl-mem0


simple code:

static const struct cxl_cmd cxl_cmd_set_my_cmds[256][256] = {
    [MY_CMDS][GET_INFO] = { "SPECIAL_GET_INFO",
      cmd_my_cmds_get_info, 0, 0 },}

static void cxl_my_cmds_realize(DeviceState *d, Error **errp)
{
    CXL_MyCmds_State *s = CXL_MyCmds(d);

    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
        CXLType3Dev *ct3d = CXL_TYPE3(s->target);

        s->type = cxl_type3;
        s->cci = &ct3d->cci;

        cxl_add_cci_commands(&ct3d->cci, cxl_cmd_set_my_cmds, 512);
        return;
    }
    error_setg(errp, "Unhandled target type for CXL MHDSLD");
}

#define TYPE_CXL_Niagara "cxl-my-cmds"
static const TypeInfo cxl_my_cmds_info = {
    .name = TYPE_CXL_MyCmds,
    .parent = TYPE_CXL_TYPE3,
    .class_size = sizeof(struct CXL_MyCmdsClass),
    .class_init = cxl_my_cmds_class_init,
    .instance_size = sizeof(CXL_MyCmds_State),
    .interfaces = (InterfaceInfo[]) {
        { INTERFACE_CXL_DEVICE },
        { INTERFACE_PCIE_DEVICE },
        {}
    },
};

Signed-off-by: Gregory Price <gregory.price@memverge.com>

---
Gregory Price (2):
  cxl/mailbox: change CCI cmd set structure to be a member, not a
    refernce
  cxl/mailbox: interface to add CCI commands to an existing CCI

 hw/cxl/cxl-mailbox-utils.c  | 37 +++++++++++++++++++++++++++++++++----
 include/hw/cxl/cxl_device.h |  4 +++-
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.39.1

