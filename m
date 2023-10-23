Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545E14281
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/F2J1U2"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331EC9B
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 12:48:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso3526880a91.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698090504; x=1698695304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+tiyOH1TnHMgGsQR+KPx44H5svtCnR0KCP+/jzjfzM=;
        b=X/F2J1U2fUbd5N8SSUwlj9dJBxVItjnVm2uLGXA5zLgnUnalaQFUMS/lOL8/nrxTrY
         gIzvS9qrASVeRC9qnJyEVFgCOX5uAXxiY6fvDu8BlIeHkLigBqybBXRUlAsJEuXvG7WB
         t0A51ceYQRBQcZnsSSsNABlBN35A5+6B1cNhIuDRZJwmt1oxuJqgj2+1B0GPxE2beep2
         OE3N8egVHHXsKa+szBlAyJdeDqx8GZ6dAb0qEeJXYc7L2mfk2B+huDbSH5ZENNO4YT6z
         5Op+OG+tNF01ntLPYshzA1enJAMf5cCOEOMDgzQyXnEtr7ouiUrFpvRr5m73nC2cl9PZ
         vKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090504; x=1698695304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+tiyOH1TnHMgGsQR+KPx44H5svtCnR0KCP+/jzjfzM=;
        b=Kne8UwLM4fRffsLfRomhy6sOOtiip7HCtexLN6rfyYPcjgDBNGQDCHh9iQmshyyKze
         6gmimGMaStCdFFH1GMoqdwN4EVpA+QJshncge+dSs58RgGvPw2Ych6ZMvhvLY5MKWJzD
         ymN6e0GPEVx3EhrXDdwxYPtOvN8TnDn3oodrLtrUpXOJh7wnyPqyc9+jpSKtXqW4/NqR
         M/P+ltt6ErJYQBrm2OhonslWkY+f6WBDxzlSR3z+lnJ/3w+0AczicZGZ7yhhJfiBcb6W
         t0R8Pt4afgOt8jIXpo2+eXu4uaZ2XzZVbNC8CtMjvXf4p+pR39xPL3fbKvl8NoAwQtW/
         pdjg==
X-Gm-Message-State: AOJu0YxGhPiRqz1wOhN9JB/6MnSLLIIuy/agq8acUhJ1OC2VO4JWH+Mc
	ZZS5v6rZ2c4PH80lFURVw18=
X-Google-Smtp-Source: AGHT+IHQ8kOJLmtmJqFkcylDTeBUG1RczqsAHdHOKbKfFZtUR0eTo8xD0/oX63o4itJR+9vj+XUpTQ==
X-Received: by 2002:a17:90a:17ef:b0:277:3afc:f27 with SMTP id q102-20020a17090a17ef00b002773afc0f27mr18070556pja.1.1698090504400;
        Mon, 23 Oct 2023 12:48:24 -0700 (PDT)
Received: from debian ([2601:641:380:4e50:5e7c:68d3:5ea1:8eb2])
        by smtp.gmail.com with ESMTPSA id gd22-20020a17090b0fd600b002791d5a3e29sm6136627pjb.6.2023.10.23.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:48:24 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 23 Oct 2023 12:48:02 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Singh, Naveen" <naveen.c.singh@intel.com>,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <ZTbN8mAa256JWTFE@debian>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>

On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:
> Fan,
> 
> I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]
> 
> I've been testing various things and so far I have a couple of questions.
> 
> 1) If the qmp command is used to add extents which overlap other extents
>    shouldn't that throw an error?  I don't see any validation of this and
>    I would think a real device would reject such a request from the FM.
> 
> 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
>    extents prior to driver load does not seem to work.  And I think this
>    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().
> 
> Ira
> 
> [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13

Hi Ira,
FYI. I have updated the DCD emulation patch series based on feedbacks on
the previous version.

The new version is here:
https://github.com/moking/qemu-jic-clone/tree/dcd-dev

The code is based on Jonathan's branch cxl-2023-09-26.

The main changes include,

1. Update cxl_find_dc_region to detect the case the range of
the extent cross multiple DC regions.
2. Add comments to explain the checks performed in function
cxl_detect_malformed_extent_list. (Jonathan)
3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
4. Update total_extent_count in add/release dynamic capacity response function.
(Ira and Jorgen Hansen).
5. Fix the logic issue in test_bits and renamed it to
test_any_bits_set to clear its function.
6. Add pending extent list for add/release extent event.
7. When add/release extent response is received, use the pending list to
verify the extents are valid.
8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
cxl_device.h so it can be used in different files.
9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event log type.
10. Extract the functionality to delete extent from extent list to a helper
function.
11. Move the update of the bitmap which reflects which blocks are backed with
dc extents from the moment when a dc extent is offered to the moment when it
is accepted from the host.

I was able to test the DCD code you sent previously, let me know if you
find any issues.

Fan
