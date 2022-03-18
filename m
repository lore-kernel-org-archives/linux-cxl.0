Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770A7C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiCRQYX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiCRQX4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 12:23:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7800313196B
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 09:20:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so3188530pjo.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7RxkEp0zKHcFi3dOuAOsG89ByGBaaumTlGp+ArO9I4=;
        b=gpaOtnP4fvETeGQcWcobGtjWtPCR6duHSZ8VsD1bWBV5uzit+S1gHP0yLDB9SwD7/M
         cJQxIK8fplvT/QOh3ZBmPZmDvJg5N15p+rJDRQFFqFdAGt+D+RB6HUrrPqq+1aw3q0yZ
         XwSeSTZVj9Z5YmoSpZpZiGDN6y9QRVuhGJSmpohH5eKrqUXAMtqTCZzazdBHYmvs7kVM
         KTMYTsJGHTujL6Fn6OcRlgOfQ04krrHtDct/Xc9S6eNOs1mYzrH/umc0zB4sp3P7QMA6
         565C2W9dCYlITpOAj9z+G9imfmRcCJZyOF1S/DyqPBVdF+c0ZDeeewYJWo664PRZmh0f
         oLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7RxkEp0zKHcFi3dOuAOsG89ByGBaaumTlGp+ArO9I4=;
        b=Sg4WH1EGSloMnXtN8qjzv3FtpPXrflL2GaGiD6cVScs/tayhvNhU3UwT9LNDWdGmyh
         PXAUg325kFVOt5Ge9/8SfHwb7Q0n+SAlMW/yrPXAOVAktQBWE9SdDK8gI5zsXQV9vLTG
         ID6xHSfjEForrEpr6Doq9PDmtX6x+mzvs9t81HhLagJBKoHWKQPgWi+DTHaYrhZPJyTR
         OBOOOrivOy8Kwzfjw2vPEr7BtpDoIetpzsTAaqMXopmlRuiKaQGw8wlQ+/iWrRoKZ7ax
         CvZlkIGttoRJLUc5DHLp1E+Uap22+aW2/lrif15MoN2Q86pUb3ZLF9/i0dqEWp51JScE
         5zYg==
X-Gm-Message-State: AOAM531+rIIO0lUa/2C3c5VhNnYC759sWx/e08Gcl3iJmiVnzXLQuKAt
        fdTAKZGlIn3EqgB9UZt4TMa3jzVJKeTIIaYVLlQP8g==
X-Google-Smtp-Source: ABdhPJxT9KFsSqQrDt2elqDYQotSuQp+/4kTOh5bXPtBTbAA9iZXoTBT53I9X/2NvIHOpxJlQJHUjeFImEwVP8SIBds=
X-Received: by 2002:a17:902:d504:b0:154:172:3677 with SMTP id
 b4-20020a170902d50400b0015401723677mr171162plg.147.1647620400388; Fri, 18 Mar
 2022 09:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317173233.w76rkwyd2tzunltd@intel.com>
In-Reply-To: <20220317173233.w76rkwyd2tzunltd@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 09:19:49 -0700
Message-ID: <CAPcyv4jPQGwM06xi2ThRjypS0Ne4pg2zawkQ=VHEFw_MyvCXPQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] cxl/pci: Prepare for mapping RAS Capability Structure
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 10:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-03-15 21:14:14, Dan Williams wrote:
> > The RAS Capabilitiy Structure is a CXL Component register capability
> > block. Unlike the HDM Decoder Capability, it will be referenced by the
> > cxl_pci driver in response to PCIe AER events. Due to this it is no
> > longer the case that cxl_map_component_regs() can assume that it should
> > map all component registers. Plumb a bitmask of capability ids to map
> > through cxl_map_component_regs().
> >
> > For symmetry cxl_probe_device_regs() is updated to populate @id in
> > 'struct cxl_reg_map' even though cxl_map_device_regs() does not have a
> > need to map a subset of the device registers per caller.
>
> This seems weird to me. You spent the first 4 or so patches consolidating the
> mapping into a nice loop only to break out an ID to do individual mappings
> again. Are you sure this is such a win over having discrete mapping functions?

The loop is still there. This allows cxl_port and cxl_pci to share all
the same logic save for a bitmap to select the block. You're angling
for a:

cxl_map_hdm_regs(&port->dev, regs, &map);

...? Internally that cxl_map_hdm_regs() should be sharing code with
cxl_map_ras_regs(), so as far as I can see "discrete mapping
functions" is just asking for the below, and I'd rather skip the extra
wrapper:

int cxl_map_hdm_regs(struct pci_dev *pdev,
                           struct cxl_component_regs *regs,
                           struct cxl_register_map *map)
{
    return cxl_map_component_regs(&port->dev, regs, &map,
BIT(CXL_CM_CAP_CAP_ID_HDM));
}
