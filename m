Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3829AC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 10:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiCYKgO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358904AbiCYKgJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 06:36:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F84CC509
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 03:34:30 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPz2M5qvFz6809b;
        Fri, 25 Mar 2022 18:33:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 25 Mar 2022 11:34:28 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:34:27 +0000
Date:   Fri, 25 Mar 2022 10:34:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 0/9]  Do not allow set-partition immediate mode
Message-ID: <20220325103426.00003916@huawei.com>
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 23 Mar 2022 18:11:17 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Blocking immediate mode in set-partition info triggered a
> refactoring of the send path of userspace mailbox commands.
> 
> The v1 to address the issue was a single patch [1] that inserted
> a new immediate mode check in the send path where the payload was
> available for examining. That was not in a validation function.
> 
> The v2 patchset [2] added refactoring of the send path so that
> validation work can all spawn from cxl_validate_cmd_from_user().
> 
> Here, v3 offers a finer level of refactoring:
> 
> Patches 1-7: Refactor existing code so that all validation work
> 	can spawn from cxl_validate_cmd_from_user().
> 
> 	The movement intends to cleanly rip the work of building a
> 	mailbox command away from handle_mailbox_command_from_user()
> 	and give it to cxl_validate_cmd_from_user().

This makes me wonder a bit if
cxl_validate_cmd_from_user() is an appropriate name given
it now does more than validation?

> 
> Patch 8: Blocks the immediate mode of the set-partition command.
> Patch 9: Removes CXL_PMEM exclusive commands restriction.
> 
> [1] https://lore.kernel.org/linux-cxl/20220103202100.784194-1-alison.schofield@intel.com/
> [2] https://lore.kernel.org/linux-cxl/a4daafc4b537a0b1a673c55300da7747784c4573.1645817416.git.alison.schofield@intel.com/
> 
> Changes in v3:
> - Split up the 'Centralize the validation...' patch into 6 pieces.
> Patch: cxl/mbox: Move cxl_mem_command construction to helper funcs
> - Safely initialize the cxl_mem_command structs. (Dan)
> - Remove unneeded memcpy (Dan)
> Patch: cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
> - No Changes
> Patch: cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
> - No Changes
> 
> Changes in v2:
> - Refactor the send path of userspace mbox cmds. (Dan, Ben)
> - Patch 3 commit log - update the need to block. (Dan)
> - Return -EBUSY (not -EINVAL), when blocking immediate mode. (Ben)
> - Remove unneeded cast of void (payload_in). (dan)
> - s/u64/__le64 in struct cxl_mbox_set_partition_info. (Dan)
> 
> Alison Schofield (9):
>   cxl/mbox: Move cxl_mem_command construction to helper funcs
>   cxl/mbox: Move raw command warning to raw command validation
>   cxl/mbox: Move build of user mailbox cmd to a helper function
>   cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
>   cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
>   cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
>   cxl/mbox: Move cxl_mem_command param to a local variable
>   cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
>   cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
> 
>  drivers/cxl/core/mbox.c | 311 +++++++++++++++++++++++++---------------
>  drivers/cxl/cxlmem.h    |   7 +
>  drivers/cxl/pmem.c      |   1 -
>  3 files changed, 200 insertions(+), 119 deletions(-)
> 
> 
> base-commit: 9b688fc651b9d2b633e8d959454670aba1c39162

