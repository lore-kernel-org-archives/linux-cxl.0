Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7F4C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 01:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjFFBgf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Jun 2023 21:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjFFBgd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Jun 2023 21:36:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E23110;
        Mon,  5 Jun 2023 18:36:30 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QZtLt1qH7z1c0HN;
        Tue,  6 Jun 2023 09:34:46 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 09:36:27 +0800
Subject: Re: [PATCH v3 0/4] acpi: Add CDAT parsing support to ACPI tables code
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>, <Jonathan.Cameron@huawei.com>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0076edb9-7e65-eeb4-38fa-fb3c4a112a40@huawei.com>
Date:   Tue, 6 Jun 2023 09:36:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 2023/6/2 5:31, Dave Jiang wrote:
> v3:
> - Move common code to lib/fw_table.c
> v2:
> - Split out with CONFIG_ACPI_TABLES_LIB to be independent
> - Fixed 0-day issues
> - Change CDAT releveant names to prefix with cdat/CDAT instead of
>    acpi/ACPI. (Jonathan)
> - Make table_header a union with cdat table header instead of
>    'acpi_table_header'. (Jonathan)
> - Removed ACPI_SIG_CDAT, already defined.
> 
> Hi Rafael,
> Please consider ack these patches. Dan can take these through the CXL tree. After
> attempting to rename the cxl_ prefixes of functions and non ACPICA data structures
> to something more common, it seems that significant amount of ACPI code would be
> touched for the rename. For this series I left it alone in order to have the minimal
> changes to ACPI code.
> 
> I've broken out the "cxl: Add support for QTG ID retrieval for CXL subsystem" [1]
> series in order to make it more manageable. Here's the first part of the ACPI
> changes. These changes are added to allow reuse of ACPI tables code to parse
> the CDAT tables. While CDAT is not part of ACPI, the table structures are similar
> to ACPI layouts that the code can be reused with some small modifications.
> 
> However, in order to be properly utilized by CXL users, the tables code needs
> to be refactored out to be independent of ACPI. For example, a PPC BE host may
> have CXL and does not have ACPI support. But it will have CDAT to read from
> devices and switches. I have created CONFIG_ACPI_TABLES_LIB in order to allow
> the common code to be independent. 0-day seems to be happy now for all the
> different configs and archs.
> 
> 1/4: Split out the common code from drivers/acpi/tables.c to lib/fw_table.c
> 2/4: Add CDAT support
> 3,4/4: These two are minor patches that has ACPICA impact. Has been merged into
>         the ACPICA git repo [3].
> 
> The whole series is at [2] for convenience.
> 
> [1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
> [3]: https://github.com/acpica/acpica/pull/874
> 
> ---
> 
> Dave Jiang (4):
>        acpi: Move common tables helper functions to common lib
>        lib/firmware_table: tables: Add CDAT table parsing support
>        acpi: fix misnamed define for CDAT DSMAS
>        acpi: Add defines for CDAT SSLBIS
> 
> 
>   drivers/acpi/Kconfig     |   1 +
>   drivers/acpi/tables.c    | 178 +----------------------------
>   include/acpi/actbl1.h    |   5 +-
>   include/linux/acpi.h     |  22 +---
>   include/linux/fw_table.h |  52 +++++++++
>   lib/Kconfig              |   3 +
>   lib/Makefile             |   2 +
>   lib/fw_table.c           | 236 +++++++++++++++++++++++++++++++++++++++

Who will maintain this file? since it's the core function of parsing
ACPI tables, I would like the update of this file in the future will
Cc ACPI mailing list.

Thanks
Hanjun
