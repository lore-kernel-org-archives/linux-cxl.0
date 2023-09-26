Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B25E7F128
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Sep 2023 20:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjIZUZF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Sep 2023 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbjIZUZE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Sep 2023 16:25:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448719C
        for <linux-cxl@vger.kernel.org>; Tue, 26 Sep 2023 13:24:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8177C433C7;
        Tue, 26 Sep 2023 20:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695759895;
        bh=CR25qClzA8w26w2bpWrG5DXhyjWZEg9+8VwxYsxisV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XdLHZyiT1w+yDO1l/aq9u5Tn5FRcaD5P+lTZYc/V1r4EWYX/HxxFTY2YYEl7UfkwF
         SprK5SdphkPMIoXpgR50e0io4NIKjb4PB7JsarlnAIquRpkqIveaSdmUDljurxXdVc
         BwiV0H1eg5ubESpEL859rNSM1wskLMT4/3VPUPrSmT5tgpBy5CwKfXMo4wL5j64zBi
         mGFVQSO13ODBOGTqM/rJNzmfKW8LXsOGbp1VoYBjjgcwGlJtFXsY7jeZbL3Z9/dIhR
         hI2Wi6kI5Apa5VJxof5lyP9/cWhi/aA0Vhey6xYULnd+qHv7MPKseEMlzLisAJW+PO
         ISdvUm1uViT8g==
Date:   Tue, 26 Sep 2023 15:24:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        bhelgaas@google.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v5 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Message-ID: <20230926202454.GA420013@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-4-Benjamin.Cheatham@amd.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 03:01:27PM -0500, Ben Cheatham wrote:
> Update EINJ documentation to include CXL errors in available_error_types
> table and usage of the types.
> 
> Also fix a formatting error in the param4 file description that caused
> the description to be on the same line as the bullet point.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 4 deletions(-)

I always feel like the documentation update should be in the same
patch as the new functionality so it's easy to match up with the code
and keep things together when backporting.  But I know that sentiment
is not universal and maybe there's good reason to keep them separate.

> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index d6b61d22f525..c6f28118c48b 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -32,6 +32,9 @@ configuration::
>    CONFIG_ACPI_APEI
>    CONFIG_ACPI_APEI_EINJ
>  
> +To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set to the same
> +value as ``CONFIG_ACPI_APEI_EINJ`` (either "y" or "m").
> ...
