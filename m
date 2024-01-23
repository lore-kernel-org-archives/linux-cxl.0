Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0796210F6;
	Tue, 23 Jan 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051440; cv=none; b=UixrFLC+GmrH1AEC4gqW2rzOMFfeo/2X/BPG2yJzNDj3wU7Vo6XVcgErREzFwfVWYNs1WxG7saaucCTr7tavCxSMwdpWUyngkR1rrnMvGe6P+6PyC0ZYKw0POO6tcU6KYvWNYTbiCWeUXF4O2ymGsbULUDfzcDTpjK/HaTi6Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051440; c=relaxed/simple;
	bh=OJH82yUjqfcH6CmG5/AaSZPFmFV6VL2JWGXPFW+Q66g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m1vNZ7Ei5NnzUGjuseJyosAaah2JR8Nh6y7NaHMQqHryOxUxZSf1iVz7ruZV9Zh4iO9TYf2jzHodZN0/jCY5lmeWEeZWHv0w/e9soVxB4YjHWwFHyORQe9/b8a33wXuMyVhFb9ulO4cf/ltjBuChU/h3Vv6KI97815XVCXl3J4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mkJLCoGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mkJLCoGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451E7C433F1;
	Tue, 23 Jan 2024 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706051440;
	bh=OJH82yUjqfcH6CmG5/AaSZPFmFV6VL2JWGXPFW+Q66g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mkJLCoGGg+23zt/YVA+qzOOg8GIVU8VrP5G6zKEXP/Xwoipf0l19UFA5f5eoxgSH2
	 fDew3FUCzs2NnwOjGhN+/6zLyligaaE79G8Yd+yjNzggQ4he7ha0eNjISvUbLZcc7L
	 civ1H30P5HY5cSHvn2i2j7r8bksYernz61mjwWy0=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: tools@linux.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc: Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org, 
 Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <20231207-series-from-non-reply-reply-v1-1-cb02de53857c@intel.com>
References: <20231207-series-from-non-reply-reply-v1-1-cb02de53857c@intel.com>
Subject: Re: [PATCH b4] am: Build patch series when additional patches
 appear in a thread
Message-Id: <170605144019.54343.6484799199692518847.b4-ty@linuxfoundation.org>
Date: Tue, 23 Jan 2024 18:10:40 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-76426


On Thu, 07 Dec 2023 21:42:37 -0800, Ira Weiny wrote:
> Dan reported that am/shazam cherry-pick was failing with a particular
> CXL series.[1]
> 
> 	$ b4 shazam -S -P _ 20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com
> 	Grabbing thread from lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/t.mbox.gz
> 	Checking for newer revisions
> 	Grabbing search results from lore.kernel.org
> 	Analyzing 8 messages in the thread
> 	Specified msgid is not present in the series, cannot cherrypick
> 
> [...]

Applied, thanks!

[1/1] am: Build patch series when additional patches appear in a thread
      commit: 76426faacd9216b0a7115262c0058eb29e2d1d69

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>

